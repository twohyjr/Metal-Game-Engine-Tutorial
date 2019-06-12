
#include <metal_stdlib>
#include "Shared.metal"
using namespace metal;

vertex RasterizerData basic_vertex_shader(const VertexIn vIn [[ stage_in ]],
                                          constant SceneConstants &sceneConstants [[ buffer(1) ]],
                                          constant ModelConstants &modelConstants [[ buffer(2) ]]){
    RasterizerData rd;
    
    float4 worldPosition = modelConstants.modelMatrix * float4(vIn.position, 1);
    rd.position = sceneConstants.projectionMatrix * sceneConstants.viewMatrix * worldPosition;
    rd.color = vIn.color;
    rd.textureCoordinate = vIn.textureCoordinate;
    rd.totalGameTime = sceneConstants.totalGameTime;
    rd.worldPosition = worldPosition.xyz;
    rd.toCameraVector = (sceneConstants.inverseViewMatrix * float4(0,0,0,1)).xyz - worldPosition.xyz;
    
    float4x4 modelViewMatrix = sceneConstants.viewMatrix * modelConstants.modelMatrix;
    rd.surfaceNormal = (modelViewMatrix * float4(vIn.normal, 0.0)).xyz;
    rd.surfaceTangent = normalize(modelViewMatrix * float4(vIn.tangent, 1.0)).xyz;
    rd.surfaceBitangent = normalize(modelViewMatrix * float4(vIn.bitangent, 1.0)).xyz;
    
    return rd;
}

fragment half4 basic_fragment_shader(RasterizerData rd [[ stage_in ]],
                                     constant Material &material [[ buffer(1) ]],
                                     constant LightData *lightDatas [[ buffer(2) ]],
                                     constant int &lightCount [[ buffer(3) ]],
                                     sampler sampler2d [[ sampler(0) ]],
                                     texture2d<float> baseTexture [[ texture(0) ]],
                                     texture2d<float> normalsTexture [[ texture(1) ]],
                                     texture2d<float> specularTexture [[ texture(2) ]]){
    float2 texCoord = rd.textureCoordinate;
    
    float4 color;
    if(material.useTexture){
        color = baseTexture.sample(sampler2d, texCoord);
    }else if(material.useMaterialColor) {
        color = material.color;
    }else{
        color = rd.color;
    }
    
    float3 unitNormal = normalize(rd.surfaceNormal);
    float3x3 TBN;
    if(material.useNormalMap){
        float4 normalsColor = normalsTexture.sample(sampler2d, texCoord);
        float3 T = normalize(rd.surfaceTangent);
        float3 B = normalize(rd.surfaceBitangent);
        float3 N = normalize(rd.surfaceNormal);
        TBN = {
            float3(T.x, B.x, N.x),
            float3(T.y, B.y, N.y),
            float3(T.z, B.z, N.z)
        };
        unitNormal = normalsColor.rgb * 2.0 - 1.0;
    }
    
    float3 specularMapIntensity = 1.0;
    if(material.useSpecularMap){
        specularMapIntensity = specularTexture.sample(sampler2d, texCoord).r * 3;
    }
    
    if(material.isLightable){
        float3 unitToCameraVector = normalize(TBN * rd.toCameraVector);
        
        float3 totalAmbient = float3(0);
        float3 totalDiffuse = float3(0);
        float3 totalSpecular = float3(0);
        
        for(int i = 0; i < lightCount; i++) {
            LightData lightData = lightDatas[i];
            
            float3 unitToLightVector = normalize(TBN * (lightData.position - rd.worldPosition));
            float3 unitLightReflection = normalize(reflect(-unitToLightVector, unitNormal));
            
            float3 ambientess = material.ambient * lightData.ambientIntensity;
            float3 ambientColor = clamp(ambientess * lightData.color * lightData.brightness, 0.0, 1.0);
            totalAmbient += ambientColor;
            
            float3 diffuseness = material.diffuse * lightData.diffuseIntensity;
            float diffuseFactor = max(dot(unitNormal, unitToLightVector), 0.0);
            float3 diffuseColor = clamp(diffuseness * diffuseFactor * lightData.color * lightData.brightness, 0.0, 1.0);
            totalDiffuse += diffuseColor;
            
            float3 specularness = material.specular * lightData.specularIntensity;
            float specularFactor = pow(max(dot(unitLightReflection, unitToCameraVector), 0.0), material.shininess);
            float3 specularColor = clamp(specularness * specularFactor * lightData.color * lightData.brightness, 0.0, 1.0);
            totalSpecular += specularColor * specularMapIntensity;
        }
        
        float3 phongIntensity = totalAmbient + totalDiffuse + totalSpecular;
        color *= float4(phongIntensity, 1.0);
    }

    return half4(color.r, color.g, color.b, color.a);
}


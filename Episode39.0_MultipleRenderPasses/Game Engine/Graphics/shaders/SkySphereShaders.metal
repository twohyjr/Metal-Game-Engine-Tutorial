#include <metal_stdlib>
#include "Shared.metal"
using namespace metal;

vertex RasterizerData skysphere_vertex_shader(const VertexIn vIn [[ stage_in ]],
                                          constant SceneConstants &sceneConstants [[ buffer(1) ]],
                                          constant ModelConstants &modelConstants [[ buffer(2) ]]){
    RasterizerData rd;
    
    float4 worldPosition = modelConstants.modelMatrix * float4(vIn.position, 1);
    rd.position = sceneConstants.projectionMatrix * sceneConstants.skyViewMatrix * worldPosition;
    rd.textureCoordinate = vIn.textureCoordinate;

    return rd;
}

fragment half4 skysphere_fragment_shader(RasterizerData rd [[ stage_in ]],
                                     sampler sampler2d [[ sampler(0) ]],
                                     texture2d<float> skySphereTexture [[ texture(10) ]]){
    float2 texCoord = rd.textureCoordinate;
    
    float4 color = skySphereTexture.sample(sampler2d, texCoord, level(0));
    
    return half4(color.r, color.g, color.b, color.a);
}


#include <metal_stdlib>
using namespace metal;

struct VertexIn{
    float3 position [[ attribute(0) ]];
    float4 color [[ attribute(1) ]];
    float2 textureCoordinate [[ attribute(2) ]];
    float3 normal [[ attribute(3) ]];
    float3 tangent [[ attribute(4) ]];
    float3 bitangent [[ attribute(5) ]];
};

struct RasterizerData{
    float4 position [[ position ]];
    float4 color;
    float2 textureCoordinate;
    float totalGameTime;
    float3 surfaceNormal;
    float3 surfaceTangent;
    float3 surfaceBitangent;
    float3 toCameraVector;
    float3 worldPosition;
    float4 positionRelativeToCam;
};

struct ModelConstants{
    float4x4 modelMatrix;
    float4x4 inverseModelMatrix;
    float3x3 normalMatrix;
};

struct SceneConstants{
    float totalGameTime;
    float4x4 viewMatrix;
    float4x4 inverseViewMatrix;
    float4x4 projectionMatrix;
};

struct Material {
    float4 color;
    bool useMaterialColor;
    bool useTexture;
    bool useNormalMap;
    bool useSpecularMap;
    bool isLightable;
    
    float3 ambient;
    float3 diffuse;
    float3 specular;
    float shininess;
};

struct LightData {
    float3 position;
    float3 color;
    float brightness;
    
    float ambientIntensity;
    float diffuseIntensity;
    float specularIntensity;
};

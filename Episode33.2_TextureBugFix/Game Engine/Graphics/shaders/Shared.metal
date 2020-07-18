#ifndef SHARED_METAL
#define SHARED_METAL

#include <metal_stdlib>
using namespace metal;

struct VertexIn {
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
    
    float3 worldPosition;
    float3 toCameraVector;
    
    float3 surfaceNormal;
    float3 surfaceTangent;
    float3 surfaceBitangent;
};

struct ModelConstants{
    float4x4 modelMatrix;
};

struct SceneConstants{
    float totalGameTime;
    float4x4 viewMatrix;
    float4x4 projectionMatrix;
    float3 cameraPosition;
};

struct Material {
    float4 color;
    bool isLit;
    bool useBaseTexture;
    bool useNormalMapTexture;
    
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

#endif

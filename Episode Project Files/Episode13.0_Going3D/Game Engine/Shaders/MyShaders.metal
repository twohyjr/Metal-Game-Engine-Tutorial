
#include <metal_stdlib>
using namespace metal;

struct VertexIn{
    float3 position [[ attribute(0) ]];
    float4 color [[ attribute(1) ]];
};

struct RasterizerData{
    float4 position [[ position ]];
    float4 color;
};

struct ModelConstants{
    float4x4 modelMatrix;
};

struct SceneConstants{
    float4x4 viewMatrix;
    float4x4 projectionMatrix;
};

vertex RasterizerData basic_vertex_shader(const VertexIn vIn [[ stage_in ]],
                                          constant SceneConstants &sceneConstants [[ buffer(1) ]],
                                          constant ModelConstants &modelConstants [[ buffer(2) ]]){
    RasterizerData rd;
    
    rd.position = sceneConstants.projectionMatrix * sceneConstants.viewMatrix * modelConstants.modelMatrix * float4(vIn.position, 1);
    rd.color = vIn.color;
    
    return rd;
}

fragment half4 basic_fragment_shader(RasterizerData rd [[ stage_in ]]){
    float4 color = rd.color;
                                                        
    return half4(color.r, color.g, color.b, color.a);
}


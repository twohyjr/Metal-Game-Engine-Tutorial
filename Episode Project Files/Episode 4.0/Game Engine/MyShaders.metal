
#include <metal_stdlib>
using namespace metal;

struct VertexIn{
    float3 position;
    float4 color;
};

struct RasterizerData{
    float4 position [[ position ]];
    float4 color;
};

vertex RasterizerData basic_vertex_shader(device VertexIn *vertices [[ buffer(0) ]],
                                  uint vertexID [[ vertex_id ]]){
    RasterizerData rd;
    
    rd.position = float4(vertices[vertexID].position, 1);
    rd.color = vertices[vertexID].color;
    
    return rd;
}

fragment half4 basic_fragment_shader(RasterizerData rd [[ stage_in ]]){
    float4 color = rd.color;
                                                        
    return half4(color.r, color.g, color.b, color.a);
}


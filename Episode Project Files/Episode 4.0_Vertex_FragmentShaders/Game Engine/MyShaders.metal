
#include <metal_stdlib>
using namespace metal;

//This vertex should be the exact same as the one in the swift file.
struct VertexIn{
    float3 position;
    float4 color;
};

//We will use this rasterizer data model to send information to the rasterizer
struct RasterizerData{
    //Add the position attribute so it does not get interpolated by the rasterizer
    float4 position [[ position ]];
    //The color value will get interpolated since does not have an attribute tag
    float4 color;
};

vertex RasterizerData basic_vertex_shader(device VertexIn *vertices [[ buffer(0) ]],
                                  uint vertexID [[ vertex_id ]]){
    RasterizerData rd;
    
    rd.position = float4(vertices[vertexID].position, 1);
    rd.color = vertices[vertexID].color;
    
    //Send off our raterizer data to be interpolated
    return rd;
}

//Tbe fragment shaders purpose is to color in each fragment (pixel) to the color returned from the rasterizer.
fragment half4 basic_fragment_shader(RasterizerData rd [[ stage_in ]]){
    float4 color = rd.color;
                                                        
    return half4(color.r, color.g, color.b, color.a);
}


#include <metal_stdlib>
#include "Shared.metal"
using namespace metal;

struct FinalRasterizerData {
    float4 position [[ position ]];
    float2 textureCoordinate;
};

vertex FinalRasterizerData final_vertex_shader(const VertexIn vIn [[ stage_in ]]) {
    FinalRasterizerData rd;
    
    rd.position = float4(vIn.position, 1.0);
    rd.textureCoordinate = vIn.textureCoordinate;
    
    return rd;
}

fragment half4 final_fragment_shader(const FinalRasterizerData rd [[ stage_in ]],
                                     texture2d<float> baseTexture) {
    sampler s;
    
    float2 textureCoordinate = rd.textureCoordinate;
    textureCoordinate.y = 1 - textureCoordinate.y;
    
    float4 color = baseTexture.sample(s, textureCoordinate);
    
    return half4(color);
}



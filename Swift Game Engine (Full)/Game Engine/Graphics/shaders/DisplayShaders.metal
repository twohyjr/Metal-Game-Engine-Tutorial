#include <metal_stdlib>
#include "Shared.metal"
using namespace metal;

struct RenderData {
    float4 position [[ position ]];
    float2 textureCoordinate;
};

vertex RenderData render_vertex_shader(const VertexIn vIn [[ stage_in ]],
                                   const uint vertexID [[ vertex_id ]]) {
    RenderData rd = {
        float4(vIn.position, 1.0),
        float2(vIn.textureCoordinate.x, 1.0 - vIn.textureCoordinate.y)
    };
    return rd;
}

fragment float4 render_fragment_shader(RenderData renderData [[ stage_in ]],
                                       texture2d<float> displayTexture [[ texture(0) ]]) {
    sampler sampler2d;
    return displayTexture.sample(sampler2d, renderData.textureCoordinate.xy);
}

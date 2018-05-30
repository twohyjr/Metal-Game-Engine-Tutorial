
#include <metal_stdlib>
using namespace metal;

struct Particle{
    float4 color;
    float2 position;
    float2 velocity;
};

struct VertexIn {
    float3 position;
    float2 texCoords;
};

struct VertexOut{
    float4 position [[ position ]];
    float2 texCoords;
};

struct ModelConstants{
    float4x4 modelMatrix;
};

vertex VertexOut vertex_function(device VertexIn *vertices [[ buffer(0) ]],
                                 constant ModelConstants &modelConstants [[ buffer(1) ]],
                                 uint vID [[ vertex_id ]]){
    VertexIn vIn = vertices[vID];
    
    VertexOut vOut;
    vOut.position = modelConstants.modelMatrix * float4(vIn.position, 1);
    vOut.texCoords = vIn.texCoords;
    return vOut;
}

fragment half4 fragment_function(VertexOut vIn [[ stage_in ]],
                                 texture2d<half> tex [[ texture(0) ]],
                                 sampler sampler2d [[sampler(0)]]){
    half4 col = tex.sample(sampler2d, vIn.texCoords);
    return col;
}

kernel void clear_kernel(texture2d<half, access::write> output [[ texture(0) ]],
                         uint2 id [[ thread_position_in_grid ]]){
    output.write(half4(0,0,0,1), id);
}

kernel void dot_kernel(device Particle *particles [[ buffer(0) ]],
                       texture2d<half, access::write> output [[ texture(0) ]],
                       uint id [[ thread_position_in_grid ]]){
    
    float width = output.get_width();
    float height = output.get_height();
    
    Particle particle;
    particle = particles[id];
    
    float2 position = particle.position;
    float2 velocity = particle.velocity;
    
    position += velocity;
    
    if(position.x < 0 || position.x > width) velocity.x *= -1;
    if(position.y < 0 || position.y > height) velocity.y *= -1;
    
    particle.position = position;
    particle.velocity = velocity;
    
    particles[id] = particle;
    
    uint2 texturePosition = uint2(position.x, position.y);
    half4 col = half4(particle.color.r, particle.color.g, particle.color.b, 1);
    output.write(col, texturePosition);
    output.write(col, texturePosition + uint2(1,0));
    output.write(col, texturePosition + uint2(0,1));
    output.write(col, texturePosition - uint2(1,0));
    output.write(col, texturePosition - uint2(0,1));
}

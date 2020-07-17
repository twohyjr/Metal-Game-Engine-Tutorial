
#include <metal_stdlib>
using namespace metal;

struct Particle{
    float4 color;
    float2 position;
    float2 velocity;
};

kernel void clear_pass_func(texture2d<half, access::write> tex [[ texture(0) ]],
                            uint2 id [[ thread_position_in_grid ]]){
    tex.write(half4(0), id);
}

kernel void draw_dots_func(device Particle *particles [[ buffer(0) ]],
                           texture2d<half, access::write> tex [[ texture(0) ]],
                           uint id [[ thread_position_in_grid ]]){
    
    float width = tex.get_width();
    float height = tex.get_height();
    
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
    tex.write(col, texturePosition);
    tex.write(col, texturePosition + uint2(1,0));
    tex.write(col, texturePosition + uint2(0,1));
    tex.write(col, texturePosition - uint2(1,0));
    tex.write(col, texturePosition - uint2(0,1));
}

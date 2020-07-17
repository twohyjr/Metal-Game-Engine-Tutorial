
#include <metal_stdlib>
using namespace metal;

//Basic vertex shader.  This doesn't do jack.

//vertex = type of shader
//float4 = return type
//basic_vertex_shader = name of the shader.  This should match the vertex function in swift.
vertex float4 basic_vertex_shader(){
    return float4(1);
}

//Likewise for the basic fragment shader

//fragment = type of shader
//half4 = return type
//basic_fragmeent_shader = name of the shader.  This should match the vertex function in swift.
fragment half4 basic_fragment_shader(){
    return half4(1);
}


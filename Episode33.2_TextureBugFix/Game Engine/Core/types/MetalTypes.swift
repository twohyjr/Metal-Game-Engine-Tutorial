import simd

public typealias float2 = SIMD2<Float>
public typealias float3 = SIMD3<Float>
public typealias float4 = SIMD4<Float>

protocol sizeable{ }
extension sizeable{
    static var size: Int{
        return MemoryLayout<Self>.size
    }
    
    static var stride: Int{
        return MemoryLayout<Self>.stride
    }
    
    static func size(_ count: Int)->Int{
        return MemoryLayout<Self>.size * count
    }
    
    static func stride(_ count: Int)->Int{
        return MemoryLayout<Self>.stride * count
    }
}

extension UInt32: sizeable { }
extension Int32: sizeable { }
extension Float: sizeable { }
extension float2: sizeable { }
extension float3: sizeable { }
extension float4: sizeable { }

struct Vertex: sizeable{
    var position: float3
    var color: float4
    var textureCoordinate: float2
    var normal: float3
    var tangent: float3
    var bitangent: float3
}

struct ModelConstants: sizeable{
    var modelMatrix = matrix_identity_float4x4
}

struct SceneConstants: sizeable {
    var totalGameTime: Float = 0
    var viewMatrix = matrix_identity_float4x4
    var projectionMatrix = matrix_identity_float4x4
    var cameraPosition = float3(0,0,0)
}

struct Material: sizeable{
    var color = float4(0.6, 0.6, 0.6, 1.0)
    var isLit: Bool = true
    var useBaseTexture: Bool = false
    var useNormalMapTexture: Bool = false
    
    var ambient: float3 = float3(0.1, 0.1, 0.1)
    var diffuse: float3 = float3(1,1,1)
    var specular: float3 = float3(1,1,1)
    var shininess: Float = 2
}

struct LightData: sizeable {
    var position: float3 = float3(0,0,0)
    var color: float3 = float3(1,1,1)
    var brightness: Float = 1.0
    
    var ambientIntensity: Float = 1.0
    var diffuseIntensity: Float = 1.0
    var specularIntensity: Float = 1.0
}

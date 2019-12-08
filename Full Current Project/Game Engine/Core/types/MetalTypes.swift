import simd

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
    var color = float4(0.8, 0.8, 0.8, 1.0)
    var useMaterialColor: Bool = false
    var useTexture: Bool = false
    var isLit: Bool = true
    
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
    
    public private(set) var endMarker: Bool = false
    internal static let endMarker = LightData(
        position: float3(0,0,0),
        color: float3(0,0,0),
        brightness: 0,
        ambientIntensity: 0,
        diffuseIntensity: 0,
        specularIntensity: 0,
        endMarker: true
    )
}

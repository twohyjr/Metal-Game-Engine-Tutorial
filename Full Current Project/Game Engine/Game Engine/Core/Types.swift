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

extension Float: sizeable { }
extension float3: sizeable { }

struct Vertex: sizeable {
    var position: float3
    var color: float4
}

struct ModelConstants: sizeable {
    var modelMatrix = matrix_identity_float4x4
}

struct SceneConstants: sizeable {
    var viewMatrix = matrix_identity_float4x4
}


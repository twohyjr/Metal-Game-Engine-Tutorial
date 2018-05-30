import MetalKit

class Camera{
    
    var position = float3(0)
    
    var modelMatrix: matrix_float4x4{
        var modelMatrix = matrix_identity_float4x4
        modelMatrix.translate(direction: -position)
        return modelMatrix
    }
    
}

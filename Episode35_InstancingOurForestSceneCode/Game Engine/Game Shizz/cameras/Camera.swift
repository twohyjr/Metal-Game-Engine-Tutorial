
import simd

enum CameraTypes {
    case Debug
}

class Camera: Node {
    var cameraType: CameraTypes!
    
    private var _viewMatrix = matrix_identity_float4x4
    var viewMatrix: matrix_float4x4 {
        return _viewMatrix
    }
    
    var projectionMatrix: matrix_float4x4 {
        return matrix_identity_float4x4
    }
    
    init(name: String, cameraType: CameraTypes){
        super.init(name: name)
        self.cameraType = cameraType
    }
    
    override func updateModelMatrix() {
        _viewMatrix = matrix_identity_float4x4
        _viewMatrix.rotate(angle: self.getRotationX(), axis: X_AXIS)
        _viewMatrix.rotate(angle: self.getRotationY(), axis: Y_AXIS)
        _viewMatrix.rotate(angle: self.getRotationZ(), axis: Z_AXIS)
        _viewMatrix.translate(direction: -getPosition())
    }
}

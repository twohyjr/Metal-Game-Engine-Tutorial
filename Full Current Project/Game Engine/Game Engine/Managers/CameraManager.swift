import MetalKit

enum CameraTypes {
    case Debug
}

class CameraManager {
    
    private var _cameras: [CameraTypes: Camera] = [:]
    private var _currentCamera: Camera!
    
    public var CurrentCamera: Camera {
        return _currentCamera
    }
    
    public func setCamera(_ cameraType: CameraTypes){
        _currentCamera = _cameras[cameraType]
    }
    
    func registerCamera(cameraType: CameraTypes, camera: Camera){
        _cameras.updateValue(camera, forKey: cameraType)
    }
    
    func updateCameras(deltaTime: Float){
        for camera in _cameras.values {
            camera.update(deltaTime: deltaTime)
        }
    }
    
}



protocol Camera {
    var position: float3 { get set }
    func update(deltaTime: Float)
}

extension Camera {
    var viewMatrix: matrix_float4x4 {
        var viewMatrix = matrix_identity_float4x4
        
        viewMatrix.translate(direction: -self.position)
        
        return viewMatrix
    }
}

public class Debug_Camera: Camera {
    var position: float3 = float3(0)
    
    func update(deltaTime: Float) {
        if(Keyboard.IsKeyPressed(.leftArrow)){
            self.position.x -= deltaTime
        }
        
        if(Keyboard.IsKeyPressed(.rightArrow)){
            self.position.x += deltaTime
        }
        
        if(Keyboard.IsKeyPressed(.upArrow)){
            self.position.y += deltaTime
        }
        
        if(Keyboard.IsKeyPressed(.downArrow)){
            self.position.y -= deltaTime
        }
    }
}



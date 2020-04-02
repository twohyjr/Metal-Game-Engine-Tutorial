import simd

class DebugCamera: Camera {
    var cameraType: CameraTypes = CameraTypes.Debug
    
    var position: float3 = float3(0,0,0)
    
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

import simd

class DebugCamera: Camera {
    override var projectionMatrix: matrix_float4x4 {
        return matrix_float4x4.perspective(degreesFov: 45.0,
                                           aspectRatio: Renderer.AspectRatio,
                                           near: 0.1,
                                           far: 1000)
    }
    
    init() {
        super.init(name: "Debug", cameraType: .Debug)
    }

    override func doUpdate() {
        if(Keyboard.IsKeyPressed(.leftArrow)){
            self.moveX(-GameTime.DeltaTime)
        }
        
        if(Keyboard.IsKeyPressed(.rightArrow)){
            self.moveX(GameTime.DeltaTime)
        }
        
        if(Keyboard.IsKeyPressed(.upArrow)){
            self.moveY(GameTime.DeltaTime)
        }
        
        if(Keyboard.IsKeyPressed(.downArrow)){
            self.moveY(-GameTime.DeltaTime)
        }
        
        if(Mouse.IsMouseButtonPressed(button: .right)) {
            self.rotate(Mouse.GetDY() * GameTime.DeltaTime,
                        Mouse.GetDX() * GameTime.DeltaTime,
                        0)
        }
        
        if(Mouse.IsMouseButtonPressed(button: .center)) {
            self.moveX(-Mouse.GetDX() * GameTime.DeltaTime)
            self.moveY(Mouse.GetDY() * GameTime.DeltaTime)
        }
        
        self.moveZ(-Mouse.GetDWheel() * 0.1)
    }
}

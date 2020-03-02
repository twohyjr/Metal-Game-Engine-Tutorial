class SandboxScene: Scene{
    var debugCamera = DebugCamera()
    var theSuzannes = TheSuzannes()
    var sun = Sun()
    override func buildScene() {
        debugCamera.setPosition(0,0,10)
        addCamera(debugCamera)
        
        sun.setPosition(float3(0, 5, 5))
        addLight(sun)
        
        addChild(theSuzannes)
    }
    
    override func doUpdate() {
        if(Mouse.IsMouseButtonPressed(button: .left)){
            theSuzannes.rotateX(Mouse.GetDY() * GameTime.DeltaTime)
            theSuzannes.rotateY(Mouse.GetDX() * GameTime.DeltaTime)
        }
    }
}

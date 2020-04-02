class SandboxScene: Scene{
    var debugCamera = DebugCamera()
    var theSuzannes = TheSuzannes()
    var sun = Sun()
    override func buildScene() {
        debugCamera.setPosition(0,0,10)
        addCamera(debugCamera)
        
        sun.setPosition(float3(0, 2, 2))
        sun.setMaterialIsLit(false)
        sun.setLightBrightness(0.3)
        sun.setMaterialColor(1,1,1,1)
        sun.setLightColor(1,1,1)
        addLight(sun)
        
        theSuzannes.setMaterialShininess(100)
        addChild(theSuzannes)
    }
    
    override func doUpdate() {
        if(Mouse.IsMouseButtonPressed(button: .left)){
            theSuzannes.rotateX(Mouse.GetDY() * GameTime.DeltaTime)
            theSuzannes.rotateY(Mouse.GetDX() * GameTime.DeltaTime)
        }
    }
}

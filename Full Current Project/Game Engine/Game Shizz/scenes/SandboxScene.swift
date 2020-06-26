class SandboxScene: Scene{
    var debugCamera = DebugCamera()
    var quad = Quad()
    var sun = Sun()
    override func buildScene() {
        debugCamera.setPosition(0,0,3)
        addCamera(debugCamera)
        
        sun.setPosition(float3(0, 5, 5))
        sun.setLightAmbientIntensity(0.04)
        addLight(sun)
        
        addChild(quad)
    }
    
    override func doUpdate() {
        if(Mouse.IsMouseButtonPressed(button: .left)){
            quad.rotateX(Mouse.GetDY() * GameTime.DeltaTime)
            quad.rotateY(Mouse.GetDX() * GameTime.DeltaTime)
        }
    }
}

class SandboxScene: Scene{
    var debugCamera = DebugCamera()
    var chest = Quad()
    var sun = Sun()
    override func buildScene() {
        debugCamera.setPosition(0,0,3)
        addCamera(debugCamera)
        
        sun.setPosition(float3(0, 5, 5))
        sun.setLightAmbientIntensity(0.04)
        addLight(sun)
        
        addChild(chest)
    }
    
    override func doUpdate() {
        if(Mouse.IsMouseButtonPressed(button: .left)){
            chest.rotateX(Mouse.GetDY() * GameTime.DeltaTime)
            chest.rotateY(Mouse.GetDX() * GameTime.DeltaTime)
        }
    }
}

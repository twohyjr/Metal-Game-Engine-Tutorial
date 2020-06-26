class SandboxScene: Scene{
    var debugCamera = DebugCamera()
    var well = GameObject(name: "Well", meshType: .Well)
    var sun = Sun()
    override func buildScene() {
        debugCamera.setPosition(0,0,3)
        addCamera(debugCamera)
        
        sun.setPosition(float3(0, 5, 5))
        sun.setLightAmbientIntensity(0.04)
        addLight(sun)
        
        addChild(well)
    }
    
    override func doUpdate() {
        if(Mouse.IsMouseButtonPressed(button: .left)){
            well.rotateX(Mouse.GetDY() * GameTime.DeltaTime)
            well.rotateY(Mouse.GetDX() * GameTime.DeltaTime)
        }
    }
}

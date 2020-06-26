class SandboxScene: Scene{
    var debugCamera = DebugCamera()
    var well = GameObject(name: "Well", meshType: .Well)
    var sun = Sun()
    override func buildScene() {
        debugCamera.setPosition(0,0,8)
        addCamera(debugCamera)
        
        sun.setPosition(float3(-3, 5, 0))
        sun.setLightAmbientIntensity(0.04)
        addLight(sun)
        
        well.moveY(-1.5)
        well.rotateY(1)
        addChild(well)
    }
    
    override func doUpdate() {
        if(Mouse.IsMouseButtonPressed(button: .left)){
            well.rotateX(Mouse.GetDY() * GameTime.DeltaTime)
            well.rotateY(Mouse.GetDX() * GameTime.DeltaTime)
        }
    }
}

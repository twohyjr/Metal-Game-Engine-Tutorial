class SandboxScene: Scene{
    var debugCamera = DebugCamera()
    var well = GameObject(name: "Well", meshType: .Well)
    var sun = Sun()
    override func buildScene() {
        debugCamera.setPosition(0,0,8)
        addCamera(debugCamera)
        
        sun.setPosition(float3(0, 5, 5))
        sun.setLightAmbientIntensity(0.04)
        addLight(sun)
        
        well.moveY(-1.5)
        well.moveX(-2)
        well.rotateY(1)
        addChild(well)
        
        let quad = Quad()
        quad.useBaseColorTexture(.PartyPirateParot)
        quad.setScale(2)
        quad.moveX(2)
        addChild(quad)
    }
    
    override func doUpdate() {
        if(Mouse.IsMouseButtonPressed(button: .left)){
            well.rotateX(Mouse.GetDY() * GameTime.DeltaTime)
            well.rotateY(Mouse.GetDX() * GameTime.DeltaTime)
        }
    }
}

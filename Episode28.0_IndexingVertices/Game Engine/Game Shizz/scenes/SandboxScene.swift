class SandboxScene: Scene{
    var debugCamera = DebugCamera()
    var quad = Quad()
    var sun = Sun()
    override func buildScene() {
        debugCamera.setPosition(0,0,4)
        addCamera(debugCamera)
        
        sun.setPosition(float3(0, 2, 2))
        sun.setMaterialIsLit(false)
        sun.setLightBrightness(0.3)
        sun.setMaterialColor(1,1,1,1)
        sun.setLightColor(1,1,1)
        addLight(sun)
        
        quad.setMaterialAmbient(0.01)
        quad.setMaterialShininess(10)
        quad.setMaterialSpecular(5)
        quad.setTexture(.PartyPirateParot)
        addChild(quad)
    }
    
    override func doUpdate() {
        if(Mouse.IsMouseButtonPressed(button: .left)){
            quad.rotateX(Mouse.GetDY() * GameTime.DeltaTime)
            quad.rotateY(Mouse.GetDX() * GameTime.DeltaTime)
        }
    }
}

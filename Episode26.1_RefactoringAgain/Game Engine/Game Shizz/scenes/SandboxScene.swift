class SandboxScene: Scene{
    var debugCamera = DebugCamera()
    var cruiser = Cruiser()
    var leftSun = Sun()
    var middleSun = Sun()
    var rightSun = Sun()
    override func buildScene() {
        debugCamera.setPosition(0,0,4)
        addCamera(debugCamera)
        
        leftSun.setPosition(-1, 1, 0)
        leftSun.setMaterialIsLit(false)
        leftSun.setMaterialColor(1,0,0,1)
        leftSun.setLightColor(1,0,0)
        addLight(leftSun)
        
        middleSun.setPosition(float3(0, 1, 0))
        middleSun.setMaterialIsLit(false)
        middleSun.setLightBrightness(0.3)
        middleSun.setMaterialColor(1,1,1,1)
        middleSun.setLightColor(1,1,1)
        addLight(middleSun)
        
        rightSun.setPosition(1, 1, 0)
        rightSun.setMaterialIsLit(false)
        rightSun.setMaterialColor(0,0,1,1)
        rightSun.setLightColor(0,0,1)
        addLight(rightSun)
        
        cruiser.setMaterialAmbient(0.01)
        cruiser.setRotationX(0.5)
        cruiser.setMaterialShininess(10)
        cruiser.setMaterialSpecular(5)
        addChild(cruiser)
    }
    
    override func doUpdate() {
        if(Mouse.IsMouseButtonPressed(button: .left)){
            cruiser.rotateX(Mouse.GetDY() * GameTime.DeltaTime)
            cruiser.rotateY(Mouse.GetDX() * GameTime.DeltaTime)
        }

        cruiser.setMaterialShininess(cruiser.getShininess() + Mouse.GetDWheel())
    }
}

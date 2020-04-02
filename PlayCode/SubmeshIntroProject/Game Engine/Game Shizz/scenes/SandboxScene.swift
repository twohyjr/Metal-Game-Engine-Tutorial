class SandboxScene: Scene{
    var debugCamera = DebugCamera()
    var chest1 = Chest_0()
    var chest2 = Chest_1()
    var chest3 = Chest_2()
    var sun = Sun()
    override func buildScene() {
        debugCamera.setPosition(0,0,4)
        addCamera(debugCamera)
        
        sun.setPosition(float3(0, 0, 5))
        addLight(sun)
        
        chest1.setPositionY(0)
        chest1.moveX(-1)
        addChild(chest1)
        
        chest2.setPositionY(0)
        chest2.moveX(1)
        addChild(chest2)
        
        chest3.setPositionY(-1)
        chest3.moveX(0)
        addChild(chest3)
    }
    
    override func doUpdate() {
        if(Mouse.IsMouseButtonPressed(button: .left)){
            let dx = Mouse.GetDX()
            let dy = Mouse.GetDY()
            chest1.rotateX(dy * GameTime.DeltaTime)
            chest1.rotateY(dx * GameTime.DeltaTime)
            
            chest2.rotateX(dy * GameTime.DeltaTime)
            chest2.rotateY(dx * GameTime.DeltaTime)
            
            chest3.rotateX(dy * GameTime.DeltaTime)
            chest3.rotateY(dx * GameTime.DeltaTime)
        }
    }
}

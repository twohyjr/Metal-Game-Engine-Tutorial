import MetalKit

class SandboxScene: Scene{
    
    var debugCamera = DebugCamera()
    var cruiser = Cruiser()
    var sun = Sun()
    override func buildScene() {
        debugCamera.setPosition(float3(0,2,5))
        debugCamera.rotateX(0.3)
        addCamera(debugCamera)
        
        sun.setPosition(float3(0, 2, 2))
        addLight(sun)
        

        addChild(cruiser)
    }
    
    override func doUpdate() {
        if(Mouse.IsMouseButtonPressed(button: .left)){
            cruiser.rotateX(Mouse.GetDY() * GameTime.DeltaTime)
            cruiser.rotateY(Mouse.GetDX() * GameTime.DeltaTime)
        }
    }
}

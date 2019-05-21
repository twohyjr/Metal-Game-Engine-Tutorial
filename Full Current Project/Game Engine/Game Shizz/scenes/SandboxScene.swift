import MetalKit

class SandboxScene: Scene{
    
    var debugCamera = DebugCamera()
    var cruiser = Cruiser()
    var sun = Sun()
    override func buildScene() {
        addCamera(debugCamera)
        
        sun.setPosition(float3(0, 2, 2))
        addLight(sun)
        
        debugCamera.setPositionZ(5)

        addChild(cruiser)
    }
    
    override func doUpdate() {
        if(Mouse.IsMouseButtonPressed(button: .left)){
            cruiser.rotateX(Mouse.GetDY() * GameTime.DeltaTime)
            cruiser.rotateY(Mouse.GetDX() * GameTime.DeltaTime)
        }
    }
}

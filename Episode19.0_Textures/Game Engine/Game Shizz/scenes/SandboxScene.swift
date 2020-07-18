import MetalKit

class SandboxScene: Scene{
    
    var debugCamera = DebugCamera()
    var quad = Quad()
    override func buildScene() {
        addCamera(debugCamera)
        
        debugCamera.setPositionZ(5)

        quad.setTexture(.PartyPirateParot)
        addChild(quad)
    }
    
    override func doUpdate() {
        quad.rotateY(GameTime.DeltaTime)
    }
}

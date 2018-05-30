import MetalKit

class SandboxScene: Scene{
    
    var player = Player()
    
    override func buildScene() {
        addChild(player)
    }
    
    
    override func update(deltaTime: Float) {
        camera.position.x += 0.0004
        super.update(deltaTime: deltaTime)
    }
}

import MetalKit


class SandboxScene: Scene{
    
    var debugCamera = DebugCamera()
    let object = Cube()
    
    override func buildScene() {
        addCamera(debugCamera)
        
        object.position.z = -5
        addChild(object)
    }
    
    override func update(deltaTime: Float) {
        object.rotation.y += deltaTime
        object.rotation.x += deltaTime
        super.update(deltaTime: deltaTime)
    }
}

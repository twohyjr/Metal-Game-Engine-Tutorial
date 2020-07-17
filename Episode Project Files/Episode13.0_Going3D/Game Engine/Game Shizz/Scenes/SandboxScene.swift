import MetalKit

class SandboxScene: Scene{
    
    var debugCamera = DebugCamera()
    
    var cube = Cube()
    override func buildScene() {
        addCamera(debugCamera)
        
        debugCamera.position.z = 5
        
        addChild(cube)
    }
    
    override func update(deltaTime: Float) {
        cube.rotation.x += deltaTime
        cube.rotation.y += deltaTime
        super.update(deltaTime: deltaTime)
    }
}

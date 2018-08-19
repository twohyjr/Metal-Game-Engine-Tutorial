import MetalKit


class SandboxScene: Scene{
    
    var debugCamera = DebugCamera()
    
    override func buildScene() {
        addCamera(debugCamera)
        
        let triangle = Triangle()
        addChild(triangle)
    }
}

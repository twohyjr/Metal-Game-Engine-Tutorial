import MetalKit

class SandboxScene: Scene{
    
    var debugCamera = DebugCamera()
    
    override func buildScene() {
        addCamera(debugCamera)
        
        debugCamera.position.z = 70

        addCubes()
    }
    
    var cubeCollection: CubeCollection!
    func addCubes(){
        
        cubeCollection = CubeCollection(cubesWide: 10, cubesHigh: 10, cubesBack: 10)
        addChild(cubeCollection)
    }
    
    override func update(deltaTime: Float) {
        cubeCollection.rotation.z += deltaTime
        
        super.update(deltaTime: deltaTime)
    }

}

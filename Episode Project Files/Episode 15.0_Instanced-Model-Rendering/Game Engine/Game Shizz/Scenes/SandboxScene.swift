import MetalKit

class SandboxScene: Scene{
    
    var debugCamera = DebugCamera()
    
    override func buildScene() {
        addCamera(debugCamera)
        
        debugCamera.position.z = 100

        addCubes()
    }
    
    var cubeCollection: CubeCollection!
    func addCubes(){
        
        cubeCollection = CubeCollection(cubesWide: 20, cubesHigh: 20, cubesBack: 20)
        addChild(cubeCollection)
    }
    
    override func update(deltaTime: Float) {
        cubeCollection.rotation.z += deltaTime
        
        super.update(deltaTime: deltaTime)
    }

}

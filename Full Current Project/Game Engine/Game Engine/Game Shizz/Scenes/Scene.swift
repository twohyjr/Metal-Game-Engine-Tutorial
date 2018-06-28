import MetalKit

class Scene: Node {
    
    var sceneConstants = SceneConstants()
    var cameraManager = CameraManager()
    
    override init(){
        super.init()
        setupCameras()
        buildScene()
    }
    
    func buildScene() { }
    
    func setupCameras() { }
    
    func setSceneConstants(){
        sceneConstants.viewMatrix = cameraManager.CurrentCamera.viewMatrix
    }
    
    override func update(deltaTime: Float) {
        setSceneConstants()
        super.update(deltaTime: deltaTime)
    }
    
    override func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setVertexBytes(&sceneConstants, length: SceneConstants.stride, index: 1)
        
        super.render(renderCommandEncoder: renderCommandEncoder)
    }
    
}

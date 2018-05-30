import MetalKit

class Scene: Node{

    var camera = Camera()
    var sceneConstants = SceneConstants()
    
    override init(){
        super.init()
        buildScene()
    }
    
    internal func buildScene(){ }
    
    private func updateSceneConstants(){
        sceneConstants.viewMatrix = camera.modelMatrix
    }
    
    override func update(deltaTime: Float) {
        updateSceneConstants()
        super.update(deltaTime: deltaTime)
    }
    
    override func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setVertexBytes(&sceneConstants, length: SceneConstants.stride, index: 1)
        
        super.render(renderCommandEncoder: renderCommandEncoder)
    }
    
}

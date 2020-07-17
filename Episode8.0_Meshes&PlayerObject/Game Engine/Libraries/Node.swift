import MetalKit

class Node {
    
    func render(renderCommandEncoder: MTLRenderCommandEncoder){
        
        if let renderable = self as? Renderable {
            renderable.doRender(renderCommandEncoder)
        }
        
    }
    
}

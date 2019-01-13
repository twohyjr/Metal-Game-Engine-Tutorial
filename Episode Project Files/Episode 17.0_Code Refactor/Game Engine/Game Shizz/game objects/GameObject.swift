import MetalKit

class GameObject: Node {
    
    var modelConstants = ModelConstants()
    private var material = Material()
    
    var mesh: Mesh!
    
    init(meshType: MeshTypes) {
        mesh = Entities.Meshes[meshType]
    }
    
    override func update(deltaTime: Float){
        updateModelConstants()
        super.update(deltaTime: deltaTime)
    }
    
    private func updateModelConstants(){
        modelConstants.modelMatrix = self.modelMatrix
    }
    
}

extension GameObject: Renderable{
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.Basic])
        renderCommandEncoder.setDepthStencilState(Graphics.DepthStencilStates[.Less])
        
        //Vertex Shader
        renderCommandEncoder.setVertexBytes(&modelConstants, length: ModelConstants.stride, index: 2)
        
        //Fragment Shader
        renderCommandEncoder.setFragmentBytes(&material, length: Material.stride, index: 1)
        
        mesh.drawPrimitives(renderCommandEncoder)
    }
}

//Material Properties
extension GameObject {
    public func setColor(_ color: float4){
        self.material.color = color
        self.material.useMaterialColor = true
    }
}

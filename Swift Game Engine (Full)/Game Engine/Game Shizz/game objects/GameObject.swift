import MetalKit

class GameObject: Node {
    var renderPipelineStateType: RenderPipelineStateTypes { return .Basic }
    
    private var _modelConstants = ModelConstants()
    private var _mesh: Mesh!
    
    private var _material: Material? = nil
    
    private var _baseColorTextureType = TextureTypes.None
    private var _normalMapTextureType = TextureTypes.None

    init(name: String, meshType: MeshTypes) {
        super.init(name: name)
        _mesh = Assets.Meshes[meshType]
    }
    
    override func update(){
        _modelConstants.modelMatrix = self.modelMatrix
        
        super.update()
    }
}

extension GameObject: Renderable{
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[renderPipelineStateType])
        renderCommandEncoder.setDepthStencilState(Graphics.DepthStencilStates[.Less])
        
        //Vertex Shader
        renderCommandEncoder.setVertexBytes(&_modelConstants, length: ModelConstants.stride, index: 2)

        _mesh.drawPrimitives(renderCommandEncoder,
                             material: _material,
                             baseColorTextureType: _baseColorTextureType,
                             normalMapTextureType: _normalMapTextureType)
    }
}

//Material Properties
extension GameObject {
    public func useBaseColorTexture(_ textureType: TextureTypes) {
        self._baseColorTextureType = textureType
    }
    
    public func useNormalMapTexture(_ textureType: TextureTypes) {
        self._normalMapTextureType = textureType
    }
    
    public func useMaterial(_ material: Material) {
        _material = material
    }
}

import MetalKit

class GameObject: Node {
    
    var modelConstants = ModelConstants()
    private var material = Material()
    private var _textureType: TextureTypes = TextureTypes.None
    private var _normalTextureType: TextureTypes = TextureTypes.None
    private var _specularTextureType: TextureTypes = TextureTypes.None
    
    var mesh: Mesh!
    
    init(meshType: MeshTypes) {
        mesh = Entities.Meshes[meshType]
    }
    
    override func update(){
        updateModelConstants()
        super.update()
    }
    
    private func updateModelConstants(){
        modelConstants.modelMatrix = self.modelMatrix
        modelConstants.inverseModelMatrix = self.modelMatrix.inverse
        let modelViewMatrix = matrix_multiply(self.modelMatrix, Scene.viewmatrix)
        modelConstants.normalMatrix = modelViewMatrix.inverse.transpose.upperLeftMatrix
    }
    
}

extension GameObject: Renderable{
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.Basic])
        renderCommandEncoder.setDepthStencilState(Graphics.DepthStencilStates[.Less])
        
        //Vertex Shader
        renderCommandEncoder.setVertexBytes(&modelConstants, length: ModelConstants.stride, index: 2)
        
        //Fragment Shader
        renderCommandEncoder.setFragmentSamplerState(Graphics.SamplerStates[.Linear], index: 0)
        renderCommandEncoder.setFragmentBytes(&material, length: Material.stride, index: 1)
        if(material.useTexture) {
            renderCommandEncoder.setFragmentTexture(Entities.Textures[_textureType], index: 0)
        }
        if(material.useNormalMap){
            renderCommandEncoder.setFragmentTexture(Entities.Textures[_normalTextureType], index: 1)
        }
        if(material.useSpecularMap){
            renderCommandEncoder.setFragmentTexture(Entities.Textures[_specularTextureType], index: 2)
        }
        
        mesh.drawPrimitives(renderCommandEncoder)
    }
}

//Material Properties
extension GameObject {
    public func setMaterialColor(_ color: float4){
        self.material.color = color
        self.material.useMaterialColor = true
        self.material.useTexture = false
    }
    
    public func setTexture(_ textureType: TextureTypes) {
        self._textureType = textureType
        self.material.useTexture = true
        self.material.useMaterialColor = false
    }
    
    public func setNormalTexture(_ textureType: TextureTypes) {
        self._normalTextureType = textureType
        self.material.useNormalMap = true
    }
    
    public func setSpecularTexture(_ textureType: TextureTypes) {
        self._specularTextureType = textureType
        self.material.useSpecularMap = true
    }
    
    public func setMaterialIsLightable(_ isLightable: Bool) { self.material.isLightable = isLightable }
    public func setMaterialAmbient(_ ambient: float3) { self.material.ambient = ambient }
    public func setMaterialAmbient(_ ambient: Float) { self.material.ambient = float3(ambient, ambient, ambient) }
    public func setMaterialDiffuse(_ diffuse: float3) { self.material.diffuse = diffuse }
    public func setMaterialDiffuse(_ diffuse: Float) { self.material.diffuse = float3(diffuse, diffuse, diffuse) }
    public func setMaterialSpecular(_ specular: float3) { self.material.specular = specular }
    public func setMaterialSpecular(_ specular: Float) { self.material.specular = float3(specular, specular, specular) }
    public func setMaterialShininess(_ shininess: Float) { self.material.shininess = shininess }
}

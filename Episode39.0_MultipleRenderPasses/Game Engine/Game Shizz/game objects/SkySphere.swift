import MetalKit

class SkySphere: GameObject {
    override var renderPipelineStateType: RenderPipelineStateTypes { return .SkySphere }
    
    private var _skySphereTextureType: TextureTypes!
    init(skySphereTextureType: TextureTypes) {
        super.init(name: "SkySphere", meshType: .SkySphere)
        
        _skySphereTextureType = skySphereTextureType
        
        setScale(1000)
    }
    
    override func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setFragmentTexture(Assets.Textures[_skySphereTextureType], index: 10)
        
        super.render(renderCommandEncoder: renderCommandEncoder)
    }
}

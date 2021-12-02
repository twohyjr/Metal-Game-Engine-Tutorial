import MetalKit

class Renderer: NSObject {
    
    public static var ScreenSize = float2(0,0)
    public static var AspectRatio: Float { return ScreenSize.x / ScreenSize.y }
    
    private var _baseRenderPassDescriptor: MTLRenderPassDescriptor!
    
    init(_ mtkView: MTKView) {
        super.init()
        
        updateScreenSize(view: mtkView)
        
        SceneManager.Initialize(Preferences.StartingSceneType)
        
        createBaseRenderPassDescriptor()
    }
    
    private func createBaseRenderPassDescriptor() {
        // ---- BASE COLOR 0 TEXTURE ----
        let base0TextureDescriptor = MTLTextureDescriptor.texture2DDescriptor(pixelFormat: Preferences.MainPixelFormat,
                                                                             width: Int(Renderer.ScreenSize.x),
                                                                             height: Int(Renderer.ScreenSize.y),
                                                                             mipmapped: false)
        base0TextureDescriptor.usage = [.renderTarget, .shaderRead]
        Assets.Textures.setTexture(textureType: .BaseColorRender_0,
                                   texture: Engine.Device.makeTexture(descriptor: base0TextureDescriptor)!)
        
        // ---- BASE COLOR 1 TEXTURE ----
        let base1TextureDescriptor = MTLTextureDescriptor.texture2DDescriptor(pixelFormat: Preferences.MainPixelFormat,
                                                                             width: Int(Renderer.ScreenSize.x),
                                                                             height: Int(Renderer.ScreenSize.y),
                                                                             mipmapped: false)
        base1TextureDescriptor.usage = [.renderTarget, .shaderRead]
        Assets.Textures.setTexture(textureType: .BaseColorRender_1,
                                   texture: Engine.Device.makeTexture(descriptor: base1TextureDescriptor)!)
        

        // ---- BASE DEPTH TEXTURE ----
        let depthTextureDescriptor = MTLTextureDescriptor.texture2DDescriptor(pixelFormat: Preferences.MainDepthPixelFormat,
                                                                              width: Int(Renderer.ScreenSize.x),
                                                                              height: Int(Renderer.ScreenSize.y),
                                                                              mipmapped: false)
        depthTextureDescriptor.usage = [.renderTarget]
        depthTextureDescriptor.storageMode = .private
        Assets.Textures.setTexture(textureType: .BaseDepthRender,
                                   texture: Engine.Device.makeTexture(descriptor: depthTextureDescriptor)!)
        
        
        self._baseRenderPassDescriptor = MTLRenderPassDescriptor()
        self._baseRenderPassDescriptor.colorAttachments[0].texture = Assets.Textures[.BaseColorRender_0]!
        self._baseRenderPassDescriptor.colorAttachments[0].storeAction = .store
        self._baseRenderPassDescriptor.colorAttachments[0].loadAction = .clear
        
        self._baseRenderPassDescriptor.colorAttachments[1].texture = Assets.Textures[.BaseColorRender_1]!
        self._baseRenderPassDescriptor.colorAttachments[1].storeAction = .store
        self._baseRenderPassDescriptor.colorAttachments[1].loadAction = .clear
        
        self._baseRenderPassDescriptor.depthAttachment.texture = Assets.Textures[.BaseDepthRender]
    }
    
}

extension Renderer: MTKViewDelegate{
    
    public func updateScreenSize(view: MTKView){
        Renderer.ScreenSize = float2(Float(view.drawableSize.width), Float(view.drawableSize.height))
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        updateScreenSize(view: view)
    }
    
    func baseRenderPass(commandBuffer: MTLCommandBuffer) {
        let renderCommandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: _baseRenderPassDescriptor)
        renderCommandEncoder?.label = "Base Render Command Encoder"
        renderCommandEncoder?.pushDebugGroup("Starting Base Render")
        SceneManager.Render(renderCommandEncoder: renderCommandEncoder!)
        renderCommandEncoder?.popDebugGroup()
        renderCommandEncoder?.endEncoding()
    }
    
    func finalRenderPass(view: MTKView, commandBuffer: MTLCommandBuffer) {
        let renderCommandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: view.currentRenderPassDescriptor!)
        renderCommandEncoder?.label = "Final Render Command Encoder"
        renderCommandEncoder?.pushDebugGroup("Starting Final Render")
        
        renderCommandEncoder?.setRenderPipelineState(Graphics.RenderPipelineStates[.Final])
        renderCommandEncoder?.setFragmentTexture(Assets.Textures[.BaseColorRender_0], index: 0)
        Assets.Meshes[.Quad].drawPrimitives(renderCommandEncoder!)
        
        renderCommandEncoder?.popDebugGroup()
        renderCommandEncoder?.endEncoding()
    }
    
    func draw(in view: MTKView) {
        SceneManager.Update(deltaTime: 1 / Float(view.preferredFramesPerSecond))
        
        let commandBuffer = Engine.CommandQueue.makeCommandBuffer()
        commandBuffer?.label = "Base Command Buffer"

        baseRenderPass(commandBuffer: commandBuffer!)

        finalRenderPass(view: view, commandBuffer: commandBuffer!)

        commandBuffer?.present(view.currentDrawable!)
        commandBuffer?.commit()
    }
    
}

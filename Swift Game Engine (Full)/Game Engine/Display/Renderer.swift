import MetalKit

class Renderer: NSObject {
    public static var ScreenSize = float2(0,0)
    public static var AspectRatio: Float { return ScreenSize.x / ScreenSize.y }
    
    private var _baseRenderPassDescriptor: MTLRenderPassDescriptor!
    
    init(_ mtkView: MTKView) {
        super.init()
        
        updateScreenSize(view: mtkView)
        
        createRenderPassDescriptors(view: mtkView)
        
        SceneManager.SetScene(.Forest)
    }

    
    private func createRenderPassDescriptors(view: MTKView) {
        // Create the base texture
        let baseTextureDescriptor = MTLTextureDescriptor.texture2DDescriptor(pixelFormat: Preferences.MainPixelFormat,
                                                                             width: Int(view.drawableSize.width),
                                                                             height: Int(view.drawableSize.height),
                                                                             mipmapped: false)
        baseTextureDescriptor.storageMode = .private
        baseTextureDescriptor.usage = [.renderTarget, .shaderRead]
        Assets.Textures.setTexture(textureType: .BaseRenderTarget,
                                     texture: Engine.Device.makeTexture(descriptor: baseTextureDescriptor)!)
        
        // Create the base depth texture
        let depthTextureDescriptor = MTLTextureDescriptor.texture2DDescriptor(pixelFormat: Preferences.MainDepthPixelFormat,
                                                                              width: Int(view.drawableSize.width),
                                                                              height: Int(view.drawableSize.height),
                                                                              mipmapped: false)
        depthTextureDescriptor.storageMode = .private
        depthTextureDescriptor.usage = [.renderTarget, .shaderRead, .shaderWrite]
        Assets.Textures.setTexture(textureType: .BaseDepthTarget,
                                   texture: Engine.Device.makeTexture(descriptor: depthTextureDescriptor)!)
        
        // Attach textures and settings to the base renderPassDescriptor
        _baseRenderPassDescriptor = MTLRenderPassDescriptor()
        
        _baseRenderPassDescriptor.colorAttachments[0].texture = Assets.Textures[.BaseRenderTarget]
        _baseRenderPassDescriptor.colorAttachments[0].storeAction = .dontCare
        _baseRenderPassDescriptor.colorAttachments[0].loadAction = .clear

        _baseRenderPassDescriptor.depthAttachment.texture = Assets.Textures[.BaseDepthTarget]
    }
}

extension Renderer: MTKViewDelegate{
    
    public func updateScreenSize(view: MTKView){
        Renderer.ScreenSize = float2(Float(view.bounds.width), Float(view.bounds.height))
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        updateScreenSize(view: view)
    }
    
    // RENDER PASS #1: RENDER OUR SCENE TO AN IMAGE
    private func firstRenderPass(commandBuffer: MTLCommandBuffer) {
        let baseRenderCommandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: _baseRenderPassDescriptor)
        baseRenderCommandEncoder?.label = "Base Render Command Encoder"
        baseRenderCommandEncoder?.pushDebugGroup("Starting Base Render")
        SceneManager.Render(renderCommandEncoder: baseRenderCommandEncoder!)
        baseRenderCommandEncoder?.popDebugGroup()
        baseRenderCommandEncoder?.endEncoding()
    }
    
    // RENDER PASS #2: RENDER THE IMAGE OF OUR SCENE
    private func finalRenderPass(view: MTKView, commandBuffer: MTLCommandBuffer) {
        let displayRenderPassDescriptor = view.currentRenderPassDescriptor
        let finalRenderCommandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: displayRenderPassDescriptor!)
        finalRenderCommandEncoder?.label = "Final Render Command Encoder"
        finalRenderCommandEncoder?.pushDebugGroup("Starting Final Render")
        finalRenderCommandEncoder?.setRenderPipelineState(Graphics.RenderPipelineStates[.Render])
        finalRenderCommandEncoder?.setFragmentTexture(Assets.Textures[.BaseRenderTarget], index: 0)
        Assets.Meshes[.Quad].drawPrimitives(finalRenderCommandEncoder!)
        finalRenderCommandEncoder?.popDebugGroup()
        finalRenderCommandEncoder?.endEncoding()
    }
    
    func draw(in view: MTKView) {
        // UPDATE OUR SCENE
        SceneManager.Update(deltaTime: 1 / Float(view.preferredFramesPerSecond))
        
        // PRIMARY COMMAND BUFFER
        let commandBuffer = Engine.CommandQueue.makeCommandBuffer()!
        commandBuffer.label = "Base Command Buffer"
        
        firstRenderPass(commandBuffer: commandBuffer)

        finalRenderPass(view: view, commandBuffer: commandBuffer)
 
        // RENDER TO THE VIEW
        commandBuffer.present(view.currentDrawable!)
        commandBuffer.commit()
    }
    
}

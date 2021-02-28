import MetalKit

class Renderer: NSObject {
    public static var ScreenSize = float2(0,0)
    public static var AspectRatio: Float { return ScreenSize.x / ScreenSize.y }
    
    init(_ mtkView: MTKView) {
        super.init()
        updateScreenSize(view: mtkView)
        
        SceneManager.SetScene(Preferences.StartingSceneType)
    }
    
}

extension Renderer: MTKViewDelegate{
    
    public func updateScreenSize(view: MTKView){
        Renderer.ScreenSize = float2(Float(view.bounds.width), Float(view.bounds.height))
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        updateScreenSize(view: view)
    }
    
    func displayRenderPass(view: MTKView, commandBuffer: MTLCommandBuffer) {
        guard let displayRenderPassDescriptor = view.currentRenderPassDescriptor else { return }
        let displayRenderCommandEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: displayRenderPassDescriptor)
        displayRenderCommandEncoder?.label = "Display Render Command Encoder"
        displayRenderCommandEncoder?.pushDebugGroup("Starting Display Render")
        SceneManager.Render(renderCommandEncoder: displayRenderCommandEncoder!)
        displayRenderCommandEncoder?.popDebugGroup()
        displayRenderCommandEncoder?.endEncoding()
    }
    
    func draw(in view: MTKView) {
        SceneManager.Update(deltaTime: 1.0 / Float(view.preferredFramesPerSecond))
        
        let baseCommandBuffer = Engine.CommandQueue.makeCommandBuffer()
        baseCommandBuffer?.label = "Base Command Buffer"
        
        displayRenderPass(view: view, commandBuffer: baseCommandBuffer!)
        
        baseCommandBuffer?.present(view.currentDrawable!)
        baseCommandBuffer?.commit()
    }
    
}

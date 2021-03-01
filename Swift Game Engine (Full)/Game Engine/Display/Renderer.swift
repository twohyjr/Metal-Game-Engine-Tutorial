import MetalKit

class Renderer: NSObject {
    
    public static var ScreenSize = float2(0,0)
    public static var AspectRatio: Float { return ScreenSize.x / ScreenSize.y }
    
    init(_ mtkView: MTKView) {
        super.init()
        
        updateScreenSize(view: mtkView)
        
        SceneManager.Initialize(Preferences.StartingSceneType)
    }
    
}

extension Renderer: MTKViewDelegate{
    
    public func updateScreenSize(view: MTKView){
        Renderer.ScreenSize = float2(Float(view.bounds.width), Float(view.bounds.height))
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        updateScreenSize(view: view)
    }
    
    func draw(in view: MTKView) {
        SceneManager.Update(deltaTime: 1 / Float(view.preferredFramesPerSecond))
        
        let commandBuffer = Engine.CommandQueue.makeCommandBuffer()
        commandBuffer?.label = "Base Command Buffer"

        guard let renderPassDescriptor = view.currentRenderPassDescriptor else { return }
        let sceneRenderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        sceneRenderCommandEncoder?.label = "Scene Render Command Encoder"
        sceneRenderCommandEncoder?.pushDebugGroup("Starting Scene Render")
        SceneManager.Render(renderCommandEncoder: sceneRenderCommandEncoder!)
        sceneRenderCommandEncoder?.popDebugGroup()
        sceneRenderCommandEncoder?.endEncoding()
        
        commandBuffer?.present(view.currentDrawable!)
        commandBuffer?.commit()
    }
    
}

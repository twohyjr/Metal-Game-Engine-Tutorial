import MetalKit

class GameView: MTKView {
    
    var commandQueue: MTLCommandQueue!
    var renderPipelineState: MTLRenderPipelineState!
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        //Device = The abstract representation of the gpu
        self.device = MTLCreateSystemDefaultDevice()
        
        self.clearColor = MTLClearColor(red: 0.43, green: 0.73, blue: 0.35, alpha: 1.0)
        
        //The MTKView Pixel Format
        self.colorPixelFormat = .bgra8Unorm
        
        self.commandQueue = device?.makeCommandQueue()
        
        createRenderPipelineState()
    }
    
    func createRenderPipelineState(){
        let library = device?.makeDefaultLibrary()
        //Remember to use the same name here as on the .metal file
        let vertexFunction = library?.makeFunction(name: "basic_vertex_shader")
        let fragmentFunction = library?.makeFunction(name: "basic_fragment_shader")
        
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        
        //The actual RENDER pipline state pixel format needs to match the MTKVIEW pixel format.
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        renderPipelineDescriptor.vertexFunction = vertexFunction
        renderPipelineDescriptor.fragmentFunction = fragmentFunction
        
        do{
            renderPipelineState = try device?.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        }catch let error as NSError{
            print(error)
        }
    }
    
    override func draw(_ dirtyRect: NSRect) {
        guard let drawable = self.currentDrawable, let renderPassDescriptor = self.currentRenderPassDescriptor else { return }
        
        let commandBuffer = commandQueue.makeCommandBuffer()
        let renderCommandEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor)
        renderCommandEncoder?.setRenderPipelineState(renderPipelineState)
        
        //Set the data in the render command encoder.
        
        renderCommandEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    
}


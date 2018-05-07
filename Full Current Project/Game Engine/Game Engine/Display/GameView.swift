import MetalKit

class GameView: MTKView {
    var vertices: [Vertex]!
    var vertexBuffer: MTLBuffer!
    
    
    var renderer: Renderer!
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        self.device = MTLCreateSystemDefaultDevice()
        
        Engine.Ignite(device: device!)
        
        self.clearColor = Preferences.ClearColor
        
        self.colorPixelFormat = Preferences.MainPixelFormat
        
        self.renderer = Renderer()
        
        self.delegate = renderer
    }
    
    //Mouse Input
    
    //Keyboard Input
    
}


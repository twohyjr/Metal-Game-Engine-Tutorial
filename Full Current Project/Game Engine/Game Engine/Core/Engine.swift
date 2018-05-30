import MetalKit

class Engine {
    
    public static var Device: MTLDevice!
    public static var CommandQueue: MTLCommandQueue!
    
    public static func Ignite(device: MTLDevice){
        self.Device = device
        self.CommandQueue = device.makeCommandQueue()
        
        ShaderLibrary.Initialize()
        
        VertexDescriptorLibrary.Intialize()
        
        RenderPipelineDescriptorLibrary.Initialize()
        
        RenderPipelineStateLibrary.Initialize()
        
        MeshLibrary.Initialize()
        
    }
    
}

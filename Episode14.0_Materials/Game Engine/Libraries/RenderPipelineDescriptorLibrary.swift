import MetalKit

enum RenderPipelineDescriptorTypes {
    case Basic
}

class RenderPipelineDescriptorLibrary {
    
    private static var renderPipelineDescriptors: [RenderPipelineDescriptorTypes : RenderPipelineDescriptor] = [:]
    
    public static func Initialize() {
        createDefaultRenderPipelineDescriptors()
    }
    
    private static func createDefaultRenderPipelineDescriptors() {
        
        renderPipelineDescriptors.updateValue(Basic_RenderPipelineDescriptor(), forKey: .Basic)
        
    }
    
    public static func Descriptor(_ renderPipelineDescriptorType: RenderPipelineDescriptorTypes)->MTLRenderPipelineDescriptor{
        return renderPipelineDescriptors[renderPipelineDescriptorType]!.renderPipelineDescriptor
    }
    
}

protocol RenderPipelineDescriptor {
    var name: String { get }
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor! { get }
}

public struct Basic_RenderPipelineDescriptor: RenderPipelineDescriptor{
    var name: String = "Basic Render Pipeline Descriptor"
    var renderPipelineDescriptor: MTLRenderPipelineDescriptor!
    init(){
        renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Preferences.MainPixelFormat
        renderPipelineDescriptor.depthAttachmentPixelFormat = Preferences.MainDepthPixelFormat
        renderPipelineDescriptor.vertexFunction = ShaderLibrary.Vertex(.Basic)
        renderPipelineDescriptor.fragmentFunction = ShaderLibrary.Fragment(.Basic)
        renderPipelineDescriptor.vertexDescriptor = VertexDescriptorLibrary.Descriptor(.Basic)
    }
}

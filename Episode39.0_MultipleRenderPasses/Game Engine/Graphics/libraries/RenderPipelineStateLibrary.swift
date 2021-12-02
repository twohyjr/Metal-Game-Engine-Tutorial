import MetalKit

enum RenderPipelineStateTypes {
    case Basic
    case Instanced
    case SkySphere
    case Final
}

class RenderPipelineStateLibrary: Library<RenderPipelineStateTypes, MTLRenderPipelineState> {
    private var _library: [RenderPipelineStateTypes: RenderPipelineState] = [:]
    
    override func fillLibrary() {
        _library.updateValue(Basic_RenderPipelineState(), forKey: .Basic)
        _library.updateValue(Instanced_RenderPipelineState(), forKey: .Instanced)
        _library.updateValue(SkySphere_RenderPipelineState(), forKey: .SkySphere)
        _library.updateValue(Final_RenderPipelineState(), forKey: .Final)
    }
    
    override subscript(_ type: RenderPipelineStateTypes)->MTLRenderPipelineState {
        return _library[type]!.renderPipelineState
    }
}

class RenderPipelineState {
    
    var renderPipelineState: MTLRenderPipelineState!
    init(renderPipelineDescriptor: MTLRenderPipelineDescriptor) {
        do{
            renderPipelineState = try Engine.Device.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
        } catch let error as NSError {
            print("ERROR::CREATE::RENDER_PIPELINE_STATE::__::\(error)")
        }
    }
    
}

class Basic_RenderPipelineState: RenderPipelineState{
    init(){
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.label = "Basic Render Pipeline Descriptor"
        
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Preferences.MainPixelFormat
        renderPipelineDescriptor.colorAttachments[1].pixelFormat = Preferences.MainPixelFormat
        renderPipelineDescriptor.depthAttachmentPixelFormat = Preferences.MainDepthPixelFormat
        renderPipelineDescriptor.vertexDescriptor = Graphics.VertexDescriptors[.Basic]
        
        renderPipelineDescriptor.vertexFunction = Graphics.Shaders[.Basic_Vertex]
        renderPipelineDescriptor.fragmentFunction = Graphics.Shaders[.Basic_Fragment]
        
        super.init(renderPipelineDescriptor: renderPipelineDescriptor)
    }
}

class SkySphere_RenderPipelineState: RenderPipelineState{
    init(){
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.label = "Sky Sphere Render Pipeline Descriptor"
        
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Preferences.MainPixelFormat
        renderPipelineDescriptor.colorAttachments[1].pixelFormat = Preferences.MainPixelFormat
        renderPipelineDescriptor.depthAttachmentPixelFormat = Preferences.MainDepthPixelFormat
        renderPipelineDescriptor.vertexDescriptor = Graphics.VertexDescriptors[.Basic]
        
        renderPipelineDescriptor.vertexFunction = Graphics.Shaders[.SkySphere_Vertex]
        renderPipelineDescriptor.fragmentFunction = Graphics.Shaders[.SkySphere_Fragment]
        
        super.init(renderPipelineDescriptor: renderPipelineDescriptor)
    }
}

class Instanced_RenderPipelineState: RenderPipelineState{
    init(){
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.label = "Instanced Render Pipeline Descriptor"
        
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Preferences.MainPixelFormat
        renderPipelineDescriptor.colorAttachments[1].pixelFormat = Preferences.MainPixelFormat
        renderPipelineDescriptor.depthAttachmentPixelFormat = Preferences.MainDepthPixelFormat
        renderPipelineDescriptor.vertexDescriptor = Graphics.VertexDescriptors[.Basic]

        renderPipelineDescriptor.vertexFunction = Graphics.Shaders[.Instanced_Vertex]
        renderPipelineDescriptor.fragmentFunction = Graphics.Shaders[.Basic_Fragment]
        
        super.init(renderPipelineDescriptor: renderPipelineDescriptor)
    }
}

class Final_RenderPipelineState: RenderPipelineState{
    init(){
        let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
        renderPipelineDescriptor.label = "Final Render Pipeline Descriptor"
        
        renderPipelineDescriptor.colorAttachments[0].pixelFormat = Preferences.MainPixelFormat
        renderPipelineDescriptor.vertexDescriptor = Graphics.VertexDescriptors[.Basic]
        
        renderPipelineDescriptor.vertexFunction = Graphics.Shaders[.Final_Vertex]
        renderPipelineDescriptor.fragmentFunction = Graphics.Shaders[.Final_Fragment]
        
        super.init(renderPipelineDescriptor: renderPipelineDescriptor)
    }
}


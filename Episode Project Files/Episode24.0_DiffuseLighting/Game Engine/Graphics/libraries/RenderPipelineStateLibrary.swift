import MetalKit

enum RenderPipelineStateTypes {
    case Basic
    case Instanced
}

class RenderPipelineStateLibrary: Library<RenderPipelineStateTypes, MTLRenderPipelineState> {
    
    private var _library: [RenderPipelineStateTypes: RenderPipelineState] = [:]
    
    override func fillLibrary() {
        _library.updateValue(RenderPipelineState(renderPipelineDescriptorType: .Basic), forKey: .Basic)
        _library.updateValue(RenderPipelineState(renderPipelineDescriptorType: .Instanced), forKey: .Instanced)
    }
    
    override subscript(_ type: RenderPipelineStateTypes)->MTLRenderPipelineState {
        return _library[type]!.renderPipelineState
    }
    
}

class RenderPipelineState {
    
    var renderPipelineState: MTLRenderPipelineState!
    init(renderPipelineDescriptorType: RenderPipelineDescriptorTypes) {
        do{
            renderPipelineState = try Engine.Device.makeRenderPipelineState(descriptor: Graphics.RenderPipelineDescriptors[renderPipelineDescriptorType])
        }catch let error as NSError {
            print("ERROR::CREATE::RENDER_PIPELINE_STATE::__::\(error)")
        }
    }
    
}

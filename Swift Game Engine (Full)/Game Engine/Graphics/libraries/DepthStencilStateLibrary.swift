import MetalKit

enum DepthStencilStateTypes {
    case Less
}

class DepthStencilStateLibrary: Library<DepthStencilStateTypes, MTLDepthStencilState> {
    private var _library: [DepthStencilStateTypes: DepthStencilState] = [:]
    
    override func fillLibrary() {
        _library.updateValue(Less_DepthStencilState(), forKey: .Less)
    }
    
    override subscript(_ type: DepthStencilStateTypes)->MTLDepthStencilState{
        return _library[type]!.depthStencilState
    }
}

protocol DepthStencilState {
    var depthStencilState: MTLDepthStencilState! { get }
}

class Less_DepthStencilState: DepthStencilState {
    
    var depthStencilState: MTLDepthStencilState!
    
    init() {
        let depthStencilDescriptor = MTLDepthStencilDescriptor()
        depthStencilDescriptor.isDepthWriteEnabled = true
        depthStencilDescriptor.depthCompareFunction = .less
        depthStencilState = Engine.Device.makeDepthStencilState(descriptor: depthStencilDescriptor)
    }
    
}

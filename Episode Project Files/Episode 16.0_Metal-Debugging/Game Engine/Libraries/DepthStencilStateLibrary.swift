import MetalKit

enum DepthStencilStateTypes {
    case Less
}

class DepthStencilStateLibrary {
    
    private static var _depthStencilStates: [DepthStencilStateTypes: DepthStencilState] = [:]
    
    public static func Intitialize(){
        createDefaultDepthStencilStates()
    }
    
    private static func createDefaultDepthStencilStates(){
        _depthStencilStates.updateValue(Less_DepthStencilState(), forKey: .Less)
    }
    
    public static func DepthStencilState(_ depthStencilStateType: DepthStencilStateTypes)->MTLDepthStencilState{
        return _depthStencilStates[depthStencilStateType]!.depthStencilState
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

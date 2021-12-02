import MetalKit

enum ShaderTypes {
    // Vertex
    case Basic_Vertex
    case Instanced_Vertex
    case SkySphere_Vertex
    case Final_Vertex
    
    // Fragment
    case Basic_Fragment
    case SkySphere_Fragment
    case Final_Fragment
}

class ShaderLibrary: Library<ShaderTypes, MTLFunction> {
    private var _library: [ShaderTypes: Shader] = [:]
    
    override func fillLibrary() {
        // Vertex Shaders
        _library.updateValue(Shader(functionName: "basic_vertex_shader"), forKey: .Basic_Vertex)
        _library.updateValue(Shader(functionName: "instanced_vertex_shader"), forKey: .Instanced_Vertex)
        _library.updateValue(Shader(functionName: "skysphere_vertex_shader"), forKey: .SkySphere_Vertex)
        _library.updateValue(Shader(functionName: "final_vertex_shader"), forKey: .Final_Vertex)
        
        // Fragment Shaders
        _library.updateValue(Shader(functionName: "basic_fragment_shader"), forKey: .Basic_Fragment)
        _library.updateValue(Shader(functionName: "skysphere_fragment_shader"), forKey: .SkySphere_Fragment)
        _library.updateValue(Shader(functionName: "final_fragment_shader"), forKey: .Final_Fragment)
    }
    
    override subscript(_ type: ShaderTypes)->MTLFunction {
        return (_library[type]?.function)!
    }
}

class Shader {
    var function: MTLFunction!
    init(functionName: String) {
        self.function = Engine.DefaultLibrary.makeFunction(name: functionName)
        self.function.label = functionName
    }
}


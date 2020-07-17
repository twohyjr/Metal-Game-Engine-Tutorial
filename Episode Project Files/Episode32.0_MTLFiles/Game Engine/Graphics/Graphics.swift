
class Graphics {
    private static var _shaderLibrary: ShaderLibrary!
    public static var Shaders: ShaderLibrary { return _shaderLibrary }
    
    private static var _vertexDescriptorLibrary: VertexDescriptorLibrary!
    public static var VertexDescriptors: VertexDescriptorLibrary { return _vertexDescriptorLibrary }
    
    private static var _renderPipelineStateLibrary: RenderPipelineStateLibrary!
    public static var RenderPipelineStates: RenderPipelineStateLibrary { return _renderPipelineStateLibrary }
    
    private static var _depthStencilStateLibrary: DepthStencilStateLibrary!
    public static var DepthStencilStates: DepthStencilStateLibrary { return _depthStencilStateLibrary }
    
    private static var _samplerStateLibrary: SamplerStateLibrary!
    public static var SamplerStates: SamplerStateLibrary { return _samplerStateLibrary }
    
    public static func Initialize() {
        self._shaderLibrary = ShaderLibrary()
        self._vertexDescriptorLibrary = VertexDescriptorLibrary()
        self._renderPipelineStateLibrary = RenderPipelineStateLibrary()
        self._depthStencilStateLibrary = DepthStencilStateLibrary()
        self._samplerStateLibrary = SamplerStateLibrary()
    }
}

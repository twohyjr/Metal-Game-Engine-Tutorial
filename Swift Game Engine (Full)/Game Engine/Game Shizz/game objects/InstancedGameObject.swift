import MetalKit

class InstancedGameObject: Node {    
    private var _material = Material()
    private var _mesh: Mesh!
    
    internal var _nodeIDs: [String] = []
    private var _modelConstantBuffer: MTLBuffer!
    
    init(meshType: MeshTypes, instanceCount: Int) {
        super.init(name: "Instanced Game Object")
        self._mesh = Assets.Meshes[meshType]
        self._mesh.setInstanceCount(instanceCount)
        self.generateInstances(instanceCount)
        self.createBuffers(instanceCount)
    }
    
    func updateNodes(_ updateNodeFunction: (Node, Int)->()) {
        for (index, nodeID) in _nodeIDs.enumerated() {
            let node = EntityManager.Shared.Get(nodeID) as! Node
            updateNodeFunction(node, index)
        }
    }
    
    func generateInstances(_ instanceCount: Int){
        for _ in 0..<instanceCount {
            let node = Node(name: "\(getName())_InstancedNode")
            _nodeIDs.append(node.getID())
            EntityManager.Shared.Add(node)
        }
    }
    
    func createBuffers(_ instanceCount: Int) {
        _modelConstantBuffer = Engine.Device.makeBuffer(length: ModelConstants.stride(instanceCount), options: [])
    }
    
    override func update() {
        var pointer = _modelConstantBuffer.contents().bindMemory(to: ModelConstants.self, capacity: _nodeIDs.count)
        for nodeID in _nodeIDs {
            let node = EntityManager.Shared.Get(nodeID) as! Node
            pointer.pointee.modelMatrix = matrix_multiply(self.modelMatrix, node.modelMatrix)
            pointer = pointer.advanced(by: 1)
        }
        
        super.update()
    }
}

extension InstancedGameObject: Renderable {
    func doRender(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        renderCommandEncoder.setRenderPipelineState(Graphics.RenderPipelineStates[.Instanced])
        renderCommandEncoder.setDepthStencilState(Graphics.DepthStencilStates[.Less])
        
        //Vertex Shader
        renderCommandEncoder.setVertexBuffer(_modelConstantBuffer, offset: 0, index: 2)
        
        //Fragment Shader
        renderCommandEncoder.setFragmentBytes(&_material, length: Material.stride, index: 1)
        
        _mesh.drawPrimitives(renderCommandEncoder)
    }
}

//Material Properties
extension InstancedGameObject {
    public func setColor(_ color: float4){
        self._material.color = color
    }
    
    public func setColor(_ r: Float,_ g: Float,_ b: Float,_ a: Float) {
        setColor(float4(r,g,b,a))
    }
}


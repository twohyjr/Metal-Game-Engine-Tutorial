import MetalKit

class Node {
    private var _name: String = "Node"
    private var _id: String!
    
    private var _position: float3 = float3()
    private var _scale: float3 = .one
    private var _rotation: float3 = float3()
    
    var parentModelMatrix = matrix_identity_float4x4
    
    private var _modelMatrix = matrix_identity_float4x4
    var modelMatrix: matrix_float4x4{
        return matrix_multiply(parentModelMatrix, _modelMatrix)
    }
    
    var children: [Node] = []
    
    init(name: String){
        self._name = name
        self._id = UUID().uuidString
    }
    
    func addChild(_ child: Node){
        children.append(child)
    }
    
    func updateModelMatrix() {
        _modelMatrix = matrix_identity_float4x4
        _modelMatrix.translate(direction: _position)
        _modelMatrix.rotate(angle: _rotation.x, axis: X_AXIS)
        _modelMatrix.rotate(angle: _rotation.y, axis: Y_AXIS)
        _modelMatrix.rotate(angle: _rotation.z, axis: Z_AXIS)
        _modelMatrix.scale(axis: _scale)
    }
    
    // Override these when needed
    func afterTranslation() { }
    func afterRotation() { }
    func afterScale() { }
    
    /// Override this function instead of the update function
    func doUpdate() { }
    
    func update(){
        doUpdate()
        for child in children{
            child.parentModelMatrix = self.modelMatrix
            child.update()
        }
    }
    
    func render(renderCommandEncoder: MTLRenderCommandEncoder){
        renderCommandEncoder.pushDebugGroup("Rendering \(_name)")
        if let renderable = self as? Renderable {
            renderable.doRender(renderCommandEncoder)
        }
        
        for child in children{
            child.render(renderCommandEncoder: renderCommandEncoder)
        }
        renderCommandEncoder.popDebugGroup()
    }
}

extension Node {
    //Naming
    func setName(_ name: String){ self._name = name }
    func getName()->String{ return _name }
    func getID()->String { return _id }
    
    //Positioning and Movement
    func setPosition(_ position: float3){
        self._position = position
        updateModelMatrix()
        afterTranslation()
    }
    func setPosition(_ x: Float,_ y: Float,_ z: Float) { setPosition(float3(x,y,z)) }
    func setPositionX(_ xPosition: Float) { setPosition(xPosition, getPositionY(), getPositionZ()) }
    func setPositionY(_ yPosition: Float) { setPosition(getPositionX(), yPosition, getPositionZ()) }
    func setPositionZ(_ zPosition: Float) { setPosition(getPositionX(), getPositionY(), zPosition) }
    func move(_ x: Float, _ y: Float, _ z: Float){
        setPosition(getPositionX() + x, getPositionY() + y, getPositionZ() + z)
    }
    func moveLoc(_ x: Float, _ y: Float, _ z: Float){
        var initDir = float3(x, y, z)
        var rotationTransform = simd_mul(
            simd_quatf(angle: _rotation.x, axis: X_AXIS),
            simd_quatf(angle: _rotation.y, axis: Y_AXIS))
        rotationTransform = simd_mul(
            rotationTransform,
            simd_quatf(angle: _rotation.z, axis: Z_AXIS))
        
        initDir = simd_act(rotationTransform.inverse, initDir)
        setPosition(_position + initDir)
    }
    func moveX(_ delta: Float){ moveLoc(delta, 0, 0) }
    func moveY(_ delta: Float){ moveLoc(0, delta, 0) }
    func moveZ(_ delta: Float){ moveLoc(0, 0, delta) }
    func getPosition()->float3 { return self._position }
    func getPositionX()->Float { return self._position.x }
    func getPositionY()->Float { return self._position.y }
    func getPositionZ()->Float { return self._position.z }
    
    //Rotating
    func setRotation(_ rotation: float3) {
        self._rotation = rotation
        updateModelMatrix()
        afterRotation()
    }
    func setRotation(_ x: Float,_ y: Float,_ z: Float) { setRotation(float3(x,y,z)) }
    func setRotationX(_ xRotation: Float) { setRotation(xRotation, getRotationY(), getRotationZ()) }
    func setRotationY(_ yRotation: Float) { setRotation(getRotationX(), yRotation, getRotationZ()) }
    func setRotationZ(_ zRotation: Float) { setRotation(getRotationX(), getRotationY(), zRotation) }
    func rotate(_ x: Float, _ y: Float, _ z: Float){ setRotation(getRotationX() + x, getRotationY() + y, getRotationZ() + z)}
    func rotateX(_ delta: Float){ rotate(delta, 0, 0) }
    func rotateY(_ delta: Float){ rotate(0, delta, 0) }
    func rotateZ(_ delta: Float){ rotate(0, 0, delta) }
    func getRotation()->float3 { return self._rotation }
    func getRotationX()->Float { return self._rotation.x }
    func getRotationY()->Float { return self._rotation.y }
    func getRotationZ()->Float { return self._rotation.z }
    
    //Scaling
    func setScale(_ scale: float3){
        self._scale = scale
        updateModelMatrix()
        afterScale()
    }
    func setScale(_ x: Float,_ y: Float,_ z: Float) { setScale(float3(x,y,z)) }
    func setScale(_ scale: Float){ setScale(float3(scale, scale, scale)) }
    func setScaleX(_ scaleX: Float){ setScale(scaleX, getScaleY(), getScaleZ()) }
    func setScaleY(_ scaleY: Float){ setScale(getScaleX(), scaleY, getScaleZ()) }
    func setScaleZ(_ scaleZ: Float){ setScale(getScaleX(), getScaleY(), scaleZ) }
    func scale(_ x: Float, _ y: Float, _ z: Float) { setScale(getScaleX() + x, getScaleY() + y, getScaleZ() + z)}
    func scaleX(_ delta: Float){ scale(delta,0,0) }
    func scaleY(_ delta: Float){ scale(0,delta,0) }
    func scaleZ(_ delta: Float){ scale(0,0,delta) }
    func getScale()->float3 { return self._scale }
    func getScaleX()->Float { return self._scale.x }
    func getScaleY()->Float { return self._scale.y }
    func getScaleZ()->Float { return self._scale.z }
}


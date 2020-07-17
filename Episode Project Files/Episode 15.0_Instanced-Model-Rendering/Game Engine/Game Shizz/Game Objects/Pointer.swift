import MetalKit

class Pointer: GameObject {
    
    private var camera: Camera!
    init(camera: Camera) {
        super.init(meshType: .Triangle_Custom)
        self.camera = camera
    }
    
    override func update(deltaTime: Float) {
        
        self.rotation.z = -atan2f(Mouse.GetMouseViewportPosition().x - position.x + camera.position.x,
                                  Mouse.GetMouseViewportPosition().y - position.y + camera.position.y)
        
        super.update(deltaTime: deltaTime)
    }
    
}

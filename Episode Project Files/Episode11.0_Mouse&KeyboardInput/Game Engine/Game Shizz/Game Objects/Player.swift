import MetalKit

class Player: GameObject {
    
    init() {
        super.init(meshType: .Triangle_Custom)
    }
    
    override func update(deltaTime: Float) {
        
        self.rotation.z = -atan2f(Mouse.GetMouseViewportPosition().x - position.x, Mouse.GetMouseViewportPosition().y - position.y)
        
        super.update(deltaTime: deltaTime)
    }
    
}

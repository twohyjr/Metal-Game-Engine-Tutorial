import MetalKit

class Sphere: GameObject {
    init() {
        super.init(meshType: .Sphere)
        setName("Sphere")
        
        setScale(3)
    }
}

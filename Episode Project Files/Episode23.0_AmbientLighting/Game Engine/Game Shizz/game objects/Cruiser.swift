import MetalKit

class Cruiser: GameObject {
    init() {
        super.init(meshType: .Cruiser)
        setName("Cruiser")
        
        setTexture(.Cruiser)
    }
}

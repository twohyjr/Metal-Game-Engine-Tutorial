import MetalKit

class Cruiser: GameObject {
    init() {
        super.init(name: "Cruiser", meshType: .Cruiser)
        setTexture(.Cruiser)
    }
}

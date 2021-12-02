import simd

class Quad: GameObject {
    init() {
        super.init(name: "Quad", meshType: .Quad)
        
        useBaseColorTexture(.BaseColorRender_0)
    }
}

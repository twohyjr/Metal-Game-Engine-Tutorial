import simd

class Sun: LightObject {
    init() {
        super.init(name: "Sun")
        self.setMaterialColor(float4(0.5, 0.5, 0, 1.0))
        self.setScale(0.3)
    }
}

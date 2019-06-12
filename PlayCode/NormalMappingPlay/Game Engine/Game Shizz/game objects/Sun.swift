import simd

class Sun: LightObject {
    init() {
        super.init(meshType: .Sphere, name: "Sun")
        self.setMaterialColor(float4(1,1,1,1))
        self.setScale(0.6)
    }
}

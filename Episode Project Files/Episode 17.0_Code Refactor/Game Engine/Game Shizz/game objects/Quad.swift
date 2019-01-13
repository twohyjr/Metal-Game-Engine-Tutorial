import simd

class Quad: GameObject {
    
    init() {
        super.init(meshType: .Quad_Custom)
        self.setName("Quad")
        
        let cube = Cube()
        cube.setScale(0.3)
        addChild(cube)
    }
    
}

import MetalKit

class CubeCollection: InstancedGameObject {
    var cubesWide: Int = 0
    var cubesHigh: Int = 0
    var cubesBack: Int = 0
    
    init(cubesWide: Int, cubesHigh: Int, cubesBack: Int) {
        super.init(meshType: .Cube_Custom, instanceCount: cubesWide * cubesHigh * cubesBack)
        self.cubesWide = cubesWide
        self.cubesHigh = cubesHigh
        self.cubesBack = cubesBack
        
        print("CUBE COUNT: \(cubesWide * cubesHigh * cubesBack)")
        
        setColor(ColorUtil.randomColor)
    }
    
    var time: Float = 0.0
    override func update(deltaTime: Float) {
        time += deltaTime
        
        let halfWide: Float = Float(cubesWide / 2)
        let halfHigh: Float = Float(cubesHigh / 2)
        let halfBack: Float = Float(cubesBack / 2)
        
        var index: Int = 0
        let gap: Float = cos(time / 2) * 10
        for y in stride(from: -halfHigh, to: halfHigh, by: 1.0) {
            let posY = Float(y * gap)
            for x in stride(from: -halfWide, to: halfWide, by: 1.0) {
                let posX = Float(x * gap)
                for z in stride(from: -halfBack, to: halfBack, by: 1.0) {
                    let posZ = Float(z * gap)
                    _nodes[index].position.y = posY
                    _nodes[index].position.x = posX
                    _nodes[index].position.z = posZ
                    _nodes[index].rotation.z -= deltaTime * 2
                    _nodes[index].rotation.y -= deltaTime * 2
                    _nodes[index].scale = float3(0.3, 0.3, 0.3)
                    index += 1
                }
            }
        }
        super.update(deltaTime: deltaTime)
    }
}

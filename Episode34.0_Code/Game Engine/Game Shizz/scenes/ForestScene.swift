import simd

class ForestScene: Scene{
    var debugCamera = DebugCamera()
    override func buildScene() {
        debugCamera.setPosition(0,1,3)
        debugCamera.setRotationX(Float(10).toRadians)
        addCamera(debugCamera)
        
        let sunColor = float4(0.7, 0.5, 0, 1.0)
        var sunMaterial = Material()
        sunMaterial.isLit = false
        sunMaterial.color = sunColor
        
        let sun = LightObject(name: "Sun", meshType: .Sphere)
        sun.setScale(5)
        sun.setPosition(float3(0, 100, 100))
        sun.useMaterial(sunMaterial)
        addLight(sun)
        
        let light = LightObject(name: "Light")
        light.setPosition(float3(0, 100, -100))
        light.setLightBrightness(0.5)
        addLight(light)
        
        // Terrain
        let terrain = GameObject(name: "Terrain", meshType: .GroundGrass)
        terrain.setScale(100)
        addChild(terrain)
        
        // Well
        let well = GameObject(name: "Well", meshType: .Well)
        well.setScale(0.3)
        well.rotateY(Float(45).toRadians)
        addChild(well)
        
        // Trees
        let treeCount: Int = 500
        let radius: Float = 10
        for i in 0..<treeCount {
            let tree = GameObject(name: "Tree", meshType: selectRandomTreeMeshType())
            let pos = float3(cos(Float(i)) * radius + Float.random(in: -2...2),
                             0,
                             sin(Float(i)) * radius + Float.random(in: -5...5))
            tree.setPosition(pos)
            tree.setScale(Float.random(in: 1...2))
            tree.rotateY(Float.random(in: 0...360))
            addChild(tree)
        }
        
        // Flowers
        let flowerCount: Int = 200
        for _ in 0..<flowerCount {
            let flower = GameObject(name: "Flower", meshType: selectRandomFlowerMeshType())
            let pos = float3(Float.random(in: -(radius-1)...(radius + 1)),
                             0,
                             Float.random(in: -(radius-1)...(radius + 1)))
            flower.setPosition(pos)
            flower.rotateY(Float.random(in: 0...360))
            addChild(flower )
        }
    }
    
    private func selectRandomTreeMeshType()->MeshTypes {
        let randVal = Int.random(in: 0..<3)
        switch randVal {
        case 0:
            return .TreePineA
        case 1:
            return .TreePineB
        case 2:
            return .TreePineC
        default:
            return .TreePineA
        }
    }
    
    private func selectRandomFlowerMeshType()->MeshTypes {
        let randVal = Int.random(in: 0..<3)
        switch randVal {
        case 0:
            return .FlowerRed
        case 1:
            return .FlowerYellow
        case 2:
            return .FlowerPurple
        default:
            return .FlowerRed
        }
    }
}

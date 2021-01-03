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
        
        // Sky Sphere
        let skySphere = SkySphere(skySphereTextureType: .Clouds_Skysphere)
        addChild(skySphere)
        
        // Terrain
        let terrain = GameObject(name: "Terrain", meshType: .GroundGrass)
        terrain.setScale(200)
        addChild(terrain)
        
        // Tent
        let tent = GameObject(name: "Tent", meshType: .Tent_Opened)
        tent.rotateY(Float(20).toRadians)
        addChild(tent)
        
        // Trees
        let trees = Trees(treeACount: 1000, treeBCount: 1000, treeCCount: 1000)
        addChild(trees)
        
        // Flowers
        let flowers = Flowers(flowerRedCount: 1500, flowerPurpleCount: 1500, flowerYellowCount: 1500)
        addChild(flowers)
    }
}

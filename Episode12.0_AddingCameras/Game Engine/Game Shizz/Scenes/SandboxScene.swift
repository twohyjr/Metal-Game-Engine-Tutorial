import MetalKit


class SandboxScene: Scene{
    
    var debugCamera = DebugCamera()
    
    override func buildScene() {
        addCamera(debugCamera)
        
        let count: Int = 5
        for y in -count..<count{
            for x in -count..<count{
                let pointer = Pointer(camera: debugCamera)
                pointer.position.y = Float(Float(y) + 0.5) / Float(count)
                pointer.position.x = Float(Float(x) + 0.5) / Float(count)
                pointer.scale = float3(0.1, 0.1, 0.1)
                addChild(pointer)
            }
        }
    }
}

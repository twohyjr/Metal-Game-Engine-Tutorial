import MetalKit

class SandboxScene: Scene{
    
    var debugCamera = DebugCamera()
    var sphere = Sphere()
    var sunMiddle = Sun()
    var sunLeft = Sun()
    var sunRight = Sun()
    override func buildScene() {
        debugCamera.setPositionZ(8)
        debugCamera.setPositionY(1)
        addCamera(debugCamera)
        
        sunMiddle.setPosition(float3(0, 2, 2))
        sunMiddle.setLightAmbientIntensity(1.0)
        sunMiddle.setLightDiffuseIntensity(1.0)
        sunMiddle.setLightSpecularIntensity(1.0)
        sunMiddle.setMaterialIsLightable(false)
        addLight(sunMiddle)
        
        sunLeft.setPosition(float3(-2, 2, 2))
        sunLeft.setMaterialColor(float4(1,0,0,1))
        sunLeft.setLightColor(float3(1,0,0))
        sunLeft.setLightAmbientIntensity(1.0)
        sunLeft.setLightDiffuseIntensity(1.0)
        sunLeft.setLightSpecularIntensity(1.0)
        sunLeft.setMaterialIsLightable(false)
        addLight(sunLeft)
        
        sunRight.setPosition(float3(2, 2, 2))
        sunRight.setMaterialColor(float4(0,0,1,1))
        sunRight.setLightColor(float3(0,0,1))
        sunRight.setLightAmbientIntensity(1.0)
        sunRight.setLightDiffuseIntensity(1.0)
        sunRight.setLightSpecularIntensity(2.0)
        sunRight.setMaterialIsLightable(false)
        addLight(sunRight)
        
        sphere.setTexture(.SandBase)
        sphere.setNormalTexture(.SandNormal)
        sphere.setSpecularTexture(.SandSpecular)
//        sphere.setMaterialColor(float4(1,1,1,1))
        sphere.setMaterialAmbient(0.6)
        sphere.setMaterialDiffuse(0.5)
        sphere.setMaterialSpecular(1)
        sphere.setMaterialShininess(0.5 * 128)
        addChild(sphere)
    }
    
    var selectedLight: [Bool] = [false, true, false]
    func setSelectedLight(_ code: KeyCodes) {
        switch code {
        case .one:
            selectedLight[0] = true
            selectedLight[1] = false
            selectedLight[2] = false
        case .two:
            selectedLight[0] = false
            selectedLight[1] = true
            selectedLight[2] = false
        case .three:
            selectedLight[0] = false
            selectedLight[1] = false
            selectedLight[2] = true
        default:
            break;
        }
    }
    
    override func doUpdate() {
        if(Mouse.IsMouseButtonPressed(button: .left)){
            if(selectedLight[0]) {
                sunLeft.moveX(Mouse.GetDX() * GameTime.DeltaTime)
                sunLeft.moveY(-Mouse.GetDY() * GameTime.DeltaTime)
            } else if(selectedLight[1]) {
                sunMiddle.moveX(Mouse.GetDX() * GameTime.DeltaTime)
                sunMiddle.moveY(-Mouse.GetDY() * GameTime.DeltaTime)
            } else if(selectedLight[2]) {
                sunRight.moveX(Mouse.GetDX() * GameTime.DeltaTime)
                sunRight.moveY(-Mouse.GetDY() * GameTime.DeltaTime)
            }
        }
        
        if(selectedLight[0]) {
            sunLeft.setLightBrightness(sunLeft.getLightBrightness() + -Mouse.GetDWheel() * GameTime.DeltaTime)
        } else if(selectedLight[1]) {
            sunMiddle.setLightBrightness(sunMiddle.getLightBrightness() + -Mouse.GetDWheel() * GameTime.DeltaTime)
        } else if(selectedLight[2]) {
            sunRight.setLightBrightness(sunRight.getLightBrightness() + -Mouse.GetDWheel() * GameTime.DeltaTime)
        }
        
        if(Keyboard.IsKeyPressed(.one)) {
            setSelectedLight(.one)
        }else if(Keyboard.IsKeyPressed(.two)) {
            setSelectedLight(.two)
        }else if(Keyboard.IsKeyPressed(.three)) {
            setSelectedLight(.three)
        }
        
        sphere.rotateY(GameTime.DeltaTime)
    }
}

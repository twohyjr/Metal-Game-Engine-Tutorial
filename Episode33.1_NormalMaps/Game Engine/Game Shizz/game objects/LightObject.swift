import MetalKit

class LightObject: GameObject {
    
    var lightData = LightData()
    
    init(name: String) {
        super.init(name: name, meshType: .None)
    }
    
    override init(name: String, meshType: MeshTypes) {
        super.init(name: name, meshType: meshType)
    }
    
    override func update() {
        self.lightData.position = self.getPosition()
        super.update()
    }
}

extension LightObject {
    // Light Color
    public func setLightColor(_ color: float3) { self.lightData.color = color }
    public func setLightColor(_ r: Float,_ g: Float,_ b: Float) { setLightColor(float3(r,g,b)) }
    public func getLightColor()->float3 { return self.lightData.color }
    
    // Light Brightness
    public func setLightBrightness(_ brightness: Float) { self.lightData.brightness = brightness }
    public func getLightBrightness()->Float { return self.lightData.brightness }

    // Ambient Intensity
    public func setLightAmbientIntensity(_ intensity: Float) { self.lightData.ambientIntensity = intensity }
    public func getLightAmbientIntensity()->Float { return self.lightData.ambientIntensity }
    
    // Diffuse Intensity
    public func setLightDiffuseIntensity(_ intensity: Float) { self.lightData.diffuseIntensity = intensity }
    public func getLightDiffuseIntensity()->Float { return self.lightData.diffuseIntensity }
    
    // Specular Intensity
    public func setLightSpecularIntensity(_ intensity: Float) { self.lightData.specularIntensity = intensity }
    public func getLightSpecularIntensity()->Float { return self.lightData.specularIntensity }
}

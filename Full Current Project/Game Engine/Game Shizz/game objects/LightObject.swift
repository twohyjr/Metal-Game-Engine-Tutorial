import MetalKit

class LightObject: GameObject {
    
    var lightData = LightData()
    
    init(name: String) {
        super.init(meshType: .None)
        self.setName(name)
    }
    
    init(meshType: MeshTypes, name: String) {
        super.init(meshType: meshType)
        self.setName(name)
    }
    
    override func update() {
        self.lightData.position = self.getPosition()
        super.update()
    }
}

extension LightObject {
    // Light Color
    public func setLightColor(_ color: float3) { self.lightData.color = color }
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

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
    public func setLightColor(_ lightColor: float3) { self.lightData.color = lightColor }
    public func setLightAmbientIntensity(_ ambientIntensiy: Float){ self.lightData.ambientIntesity = ambientIntensiy }
    public func setLightDiffuseIntensity(_ diffuseIntensiy: Float){ self.lightData.diffuseIntensity = diffuseIntensiy }
    public func setLightSpecularIntensity(_ specularIntensiy: Float){ self.lightData.specularIntensity = specularIntensiy }
    public func setLightBrightness(_ brightness: Float){ self.lightData.brightness = brightness }
    public func getLightBrightness()->Float{ return self.lightData.brightness }
}

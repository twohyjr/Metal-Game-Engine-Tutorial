import MetalKit

class LightManager {
    private var _lightObjects: [LightObject] = []
    
    func addLightObject(_ lightObject: LightObject) {
        self._lightObjects.append(lightObject)
    }
    
    private func gatherLightData()->[LightData] {
        var result: [LightData] = []
        for lightObject in _lightObjects {
            result.append(lightObject.lightData)
        }
        result.append(LightData.endMarker)
        return result
    }
    
    func setLightData(_ renderCommandEncoder: MTLRenderCommandEncoder) {
        var lightDatas = gatherLightData()
        renderCommandEncoder.setFragmentBytes(&lightDatas,
                                              length: LightData.stride(lightDatas.count),
                                              index: 2)
    }
}

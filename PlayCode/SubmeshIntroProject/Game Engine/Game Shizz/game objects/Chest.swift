import MetalKit
class Chest_0: GameObject {
    init() {
        super.init(name: "Chest_0", meshType: .Chest_0)
        setScale(0.009)
    }
    
    override func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        if(Settings.ShowLeftChest) {
            super.render(renderCommandEncoder: renderCommandEncoder)
        }
    }
}

class Chest_1: GameObject {
    init() {
        super.init(name: "Chest_1", meshType: .Chest_1)
        setScale(0.009)
    }
    
    override func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        if(Settings.ShowRightChest) {
            super.render(renderCommandEncoder: renderCommandEncoder)
        }
    }
}

class Chest_2: GameObject {
    init() {
        super.init(name: "Chest_2", meshType: .Chest_2)
        setScale(0.009)
    }
    
    override func render(renderCommandEncoder: MTLRenderCommandEncoder) {
        if(Settings.ShowMainChest) {
            super.render(renderCommandEncoder: renderCommandEncoder)
        }
    }
}

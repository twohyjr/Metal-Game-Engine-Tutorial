import MetalKit

enum SceneTypes{
    case Sandbox
}

class SceneManager{
    
    private static var CurrentScene: Scene!
    
    public static func Initialize(_ initialSceneType: SceneTypes){
        SetScene(initialSceneType)
    }
    
    public static func SetScene(_ sceneType: SceneTypes){
        switch sceneType {
        case .Sandbox:
            self.CurrentScene = SandboxScene()
        }
    }
    
    public static func TickScene(renderCommandEncoder: MTLRenderCommandEncoder, deltaTime: Float){
        CurrentScene.update(deltaTime: deltaTime)
        CurrentScene.render(renderCommandEncoder: renderCommandEncoder)
    }
    
}

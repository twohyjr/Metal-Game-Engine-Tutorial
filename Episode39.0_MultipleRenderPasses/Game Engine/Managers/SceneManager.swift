import MetalKit

enum SceneTypes{
    case Sandbox
    case Forest
}

class SceneManager{
    private static var _currentScene: Scene!
    
    public static func Initialize(_ sceneType: SceneTypes){
        SetScene(sceneType)
    }
    
    public static func SetScene(_ sceneType: SceneTypes){
        switch sceneType {
        case .Sandbox:
            _currentScene = SandboxScene(name: "Sandbox")
        case .Forest:
            _currentScene = ForestScene(name: "Forest")
        }
    }
    
    public static func Update(deltaTime: Float) {
        GameTime.UpdateTime(deltaTime)
        
        _currentScene.updateCameras()
        
        _currentScene.update()
    }
    
    public static func Render(renderCommandEncoder: MTLRenderCommandEncoder){
        _currentScene.render(renderCommandEncoder: renderCommandEncoder)
    }
}

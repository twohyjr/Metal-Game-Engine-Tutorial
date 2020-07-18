import MetalKit

class Engine {
    public static var Device: MTLDevice!
    public static var CommandQueue: MTLCommandQueue!
    public static var DefaultLibrary: MTLLibrary!
    
    public static func Ignite(device: MTLDevice){
        self.Device = device
        self.CommandQueue = device.makeCommandQueue()
        self.DefaultLibrary = device.makeDefaultLibrary()
        
        Graphics.Initialize()

        Entities.Initialize()
        
        SceneManager.Initialize(Preferences.StartingSceneType)
    }
}

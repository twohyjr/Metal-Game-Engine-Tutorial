import MetalKit

public enum ClearColors{
    static let White: MTLClearColor = MTLClearColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    static let Green: MTLClearColor = MTLClearColor(red: 0.22, green: 0.55, blue: 0.34, alpha: 1.0)
    static let Grey: MTLClearColor = MTLClearColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1.0)
    static let Black: MTLClearColor = MTLClearColor(red: 0, green: 0, blue: 0, alpha: 1)
    static let LimeGreen: MTLClearColor = MTLClearColor(red: 0.3, green: 0.7, blue: 0.3, alpha: 1) //Snuck this in :)
}

class Preferences {
    
    public static var ClearColor: MTLClearColor = ClearColors.White
    
    public static var MainPixelFormat: MTLPixelFormat = MTLPixelFormat.bgra8Unorm_srgb
    
    public static var MainDepthPixelFormat: MTLPixelFormat = MTLPixelFormat.depth32Float
    
    public static var StartingSceneType: SceneTypes = SceneTypes.Sandbox
    
}

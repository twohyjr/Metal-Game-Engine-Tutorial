
import MetalKit

class GameTime {
    private static var _totalGameTime: Float = 0.0
    private static var _deltaTime: Float = 0.0
    public static func UpdateTime(_ deltaTime: Float) {
        self._deltaTime = deltaTime
        self._totalGameTime += deltaTime
    }
}

extension GameTime {
    public static var TotalGameTime: Float {
        return self._totalGameTime
    }
    
    public static var DeltaTime: Float {
        return self._deltaTime
    }
}

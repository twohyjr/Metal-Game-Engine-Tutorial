import simd

class ColorUtil {
    public static var randomColor: float4 {
        return float4(Float.randomZeroToOne, Float.randomZeroToOne, Float.randomZeroToOne, 1.0)
    }
}

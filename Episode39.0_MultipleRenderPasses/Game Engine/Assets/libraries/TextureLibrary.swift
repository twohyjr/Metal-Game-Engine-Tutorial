import MetalKit

enum TextureTypes{
    case None
    
    case BaseColorRender_0
    case BaseColorRender_1
    case BaseDepthRender
    
    case PartyPirateParot
    case Cruiser
    
    case MetalPlate_Diffuse
    case MetalPlate_Normal
    
    // Sky Sphere
    case Clouds_Skysphere
}

class TextureLibrary: Library<TextureTypes, MTLTexture> {
    private var _library: [TextureTypes : Texture] = [:]
    
    override func fillLibrary() {
        _library.updateValue(Texture("PartyPirateParot", origin: .bottomLeft), forKey: .PartyPirateParot)
        _library.updateValue(Texture("cruiser", ext: "bmp", origin: .bottomLeft), forKey: .Cruiser)
        
        // Metal Plate
        _library.updateValue(Texture("metal_plate_diff"), forKey: .MetalPlate_Diffuse)
        _library.updateValue(Texture("metal_plate_nor"), forKey: .MetalPlate_Normal)
        
        _library.updateValue(Texture("clouds", origin: .bottomLeft), forKey: .Clouds_Skysphere)
    }
    
    func setTexture(textureType: TextureTypes, texture: MTLTexture) {
        _library.updateValue(Texture(texture: texture), forKey: textureType)
    }
    
    override subscript(_ type: TextureTypes) -> MTLTexture? {
        return _library[type]?.texture
    }
}

private class Texture {
    var texture: MTLTexture!
    
    init(texture: MTLTexture) {
        self.texture = texture
    }
    
    init(_ textureName: String, ext: String = "png", origin: MTKTextureLoader.Origin = .topLeft){
        let textureLoader = TextureLoader(textureName: textureName, textureExtension: ext, origin: origin)
        let texture: MTLTexture = textureLoader.loadTextureFromBundle()
        setTexture(texture)
    }
    
    func setTexture(_ texture: MTLTexture){
        self.texture = texture
    }
}

class TextureLoader {
    private var _textureName: String!
    private var _textureExtension: String!
    private var _origin: MTKTextureLoader.Origin!
    
    init(textureName: String, textureExtension: String = "png", origin: MTKTextureLoader.Origin = .topLeft){
        self._textureName = textureName
        self._textureExtension = textureExtension
        self._origin = origin
    }
    
    public func loadTextureFromBundle()->MTLTexture{
        var result: MTLTexture!
        if let url = Bundle.main.url(forResource: _textureName, withExtension: self._textureExtension) {
            let textureLoader = MTKTextureLoader(device: Engine.Device)
            
            let options: [MTKTextureLoader.Option : Any] = [
                MTKTextureLoader.Option.origin : _origin as Any,
                MTKTextureLoader.Option.generateMipmaps : true
            ]
            
            do{
                result = try textureLoader.newTexture(URL: url, options: options)
                result.label = _textureName
            }catch let error as NSError {
                print("ERROR::CREATING::TEXTURE::__\(_textureName!)__::\(error)")
            }
        }else {
            print("ERROR::CREATING::TEXTURE::__\(_textureName!) does not exist")
        }
        
        return result
    }
}

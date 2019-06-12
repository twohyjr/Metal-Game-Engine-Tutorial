import MetalKit

enum TextureTypes{
    case None
    case PartyPirateParot
    case Cruiser
    
    case BrickBase
    case BrickNormal
    case PavementBase
    case PavementNormal
    case SandBase
    case SandNormal
    case SandSpecular
}

class TextureLibrary: Library<TextureTypes, MTLTexture> {
    private var library: [TextureTypes : Texture] = [:]
    
    override func fillLibrary() {
        library.updateValue(Texture("PartyPirateParot"), forKey: .PartyPirateParot)
        library.updateValue(Texture("cruiser", ext: "bmp", origin: .bottomLeft), forKey: .Cruiser)
        library.updateValue(Texture("medieval-brick_basecolor", ext: "png", origin: .bottomLeft), forKey: .BrickBase)
        library.updateValue(Texture("medieval-brick_normal", ext: "png", origin: .bottomLeft), forKey: .BrickNormal)
        
        library.updateValue(Texture("pavement_basecolor", ext: "png", origin: .bottomLeft), forKey: .PavementBase)
        library.updateValue(Texture("pavement_normal", ext: "png", origin: .bottomLeft), forKey: .PavementNormal)
        
        library.updateValue(Texture("sand_basecolor", ext: "png", origin: .bottomLeft), forKey: .SandBase)
        library.updateValue(Texture("sand_normal", ext: "png", origin: .bottomLeft), forKey: .SandNormal)
        library.updateValue(Texture("sand_glossiness", ext: "png", origin: .bottomLeft), forKey: .SandSpecular)
    }
    
    override subscript(_ type: TextureTypes) -> MTLTexture? {
        return library[type]?.texture
    }
}

class Texture {
    var texture: MTLTexture!
    
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
            
            let options: [MTKTextureLoader.Option : MTKTextureLoader.Origin] = [MTKTextureLoader.Option.origin : _origin]
            
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

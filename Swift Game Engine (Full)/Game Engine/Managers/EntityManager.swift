protocol Entity {
    func getID()->String
}

class EntityManager {
    private static var _shared: EntityManager!
    public static var Shared: EntityManager {
        if(_shared == nil) {
            _shared = EntityManager()
        }
        return _shared
    }
    
    private var _entities: [String: Entity]  = [:]
    
    public func Add(_ entity: Entity) {
        _entities.updateValue(entity, forKey: entity.getID())
    }
    
    public func Get(_ id: String)->Entity {
        return _entities[id]!
    }
}

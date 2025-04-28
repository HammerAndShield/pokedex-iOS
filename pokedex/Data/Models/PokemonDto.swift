import Foundation

struct PokemonDto: Codable {
    
    let name: String
    let id: Int
    let sprites: Sprites
    let types: [DtoPokeType]
    
    struct Sprites: Codable {
        let frontDefault: String
    }
    
    struct DtoPokeType: Codable {
        let slot: Int
        let typeInfo: TypeInfo
        
        struct TypeInfo: Codable {
            let name: String
        }
        
        enum CodingKeys: String, CodingKey {
            case slot
            case typeInfo = "type"
        }
    }
        
      
    func toPokemon() throws -> Pokemon {
        guard let url = URL(string: self.sprites.frontDefault) else {
            throw URLError(.badURL)
        }
        
        let primaryType = types.first?.typeInfo.name ?? "unknown"
        let pokeType = PokeType.fromString(primaryType)
        
        return Pokemon(name: name, id: id, spriteURL: url, type: pokeType)
    }
    
}


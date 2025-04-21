import Foundation

struct PokemonDto: Codable {
    
    let name: String
    let id: Int
    let sprites: Sprites
    
    struct Sprites: Codable {
        let frontDefault: String
    }
    
    func toPokemon() throws -> Pokemon {
        guard let url = URL(string: self.sprites.frontDefault) else {
            throw URLError(.badURL)
        }
        
        return Pokemon(name: name, id: id, spriteURL: url)
    }
    
}


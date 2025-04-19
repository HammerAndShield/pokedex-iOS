

struct Pokemon: Codable {
    
    let name: String
    let id: Int
    let sprites: Sprites
    
    struct Sprites: Codable {
        let frontDefault: String
    }
    
}


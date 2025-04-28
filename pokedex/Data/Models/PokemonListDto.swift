

struct PokemonListDto: Codable {
    
    let results: [PokemonListItem]
    
    struct PokemonListItem: Codable {
        let name: String
        let url: String
    }
    
    func toDomainModel() -> [PokemonMetadata] {
        var res: [PokemonMetadata] = []
        
        for item in results {
            let path = item.url
                .split(separator: "/", omittingEmptySubsequences: true)
                .last
                .flatMap { Int($0) }
            
            guard let id = path else {
                continue
            }
            
            let metadata = PokemonMetadata(name: item.name, id: id)
            res.append(metadata)
        }
        
        return res
    }
    
}


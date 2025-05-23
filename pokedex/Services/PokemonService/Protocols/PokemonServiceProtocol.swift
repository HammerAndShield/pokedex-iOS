

protocol PokemonServiceProtocol {
    
    func getPokemonList(limit: Int) async throws(PokemonError) -> [PokemonMetadata]
    func getPokemonById(id: Int) async throws(PokemonError) -> Pokemon
    func getBulkPokemonById(ids: [Int]) async throws(PokemonError) -> [Pokemon]
    
}

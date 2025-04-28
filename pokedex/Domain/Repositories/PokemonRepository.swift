

protocol PokemonRepository {
    
    func getPokemonList(limit: Int) async throws(PokemonRepositoryError) -> [PokemonMetadata]
    func getPokemonById(id: Int) async throws(PokemonRepositoryError) -> Pokemon
    
}

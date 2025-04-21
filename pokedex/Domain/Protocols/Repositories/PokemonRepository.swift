

protocol PokemonRepository {
    
    func getPokemon(id: Int) async throws -> Pokemon
    
}

import Factory

extension Container {
    
    var pokemonReposiotry: Factory<PokemonRepository> {
        Factory(self) { RemotePokemonRepository() }.singleton
    }
    
}


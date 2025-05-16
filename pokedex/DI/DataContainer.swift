import Factory

extension Container {
    
    var pokemonRepository: Factory<PokemonRepository> {
        Factory(self) { RemotePokemonRepository() }.singleton
    }
    
}


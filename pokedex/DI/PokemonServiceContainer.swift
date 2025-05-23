import Factory

extension Container {
    
    var pokemonService: Factory<PokemonServiceProtocol> {
        Factory(self) { PokemonService() }.singleton
    }
    
}


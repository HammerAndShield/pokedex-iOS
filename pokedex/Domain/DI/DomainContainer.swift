import Factory

extension Container {
    
    var fetchBulkPokemonUseCase: Factory<FetchBulkPokemonUseCase> {
        Factory(self) {
            DefaultFetchBulkPokemonUseCase(repository: self.pokemonReposiotry.resolve())
        }.shared
    }
    
}


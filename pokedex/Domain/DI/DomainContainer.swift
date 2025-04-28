import Factory

extension Container {
    
    var fetchBulkPokemonUseCase: Factory<FetchBulkPokemonUseCase> {
        Factory(self) {
            FetchBulkPokemonUseCaseImpl(repository: self.pokemonRepository.resolve())
        }.shared
    }
    
}


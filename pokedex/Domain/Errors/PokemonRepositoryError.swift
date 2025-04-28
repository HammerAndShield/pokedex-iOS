

enum PokemonRepositoryError: Error {
    
    case domainError(PokemonError)
    case dataSourceError(reason: String, underlyingError: Error? = nil)
    case repositoryError(reason: String, underlyingError: Error? = nil)
    
}




enum PokemonError: Error {
    case notFound
    case idOutOfRange
    case dataSourceError(reason: String, underlyingError: Error? = nil)
}


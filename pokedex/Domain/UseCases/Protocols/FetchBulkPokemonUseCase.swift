

protocol FetchBulkPokemonUseCase {
    
    func execute(range: ClosedRange<Int>) async throws -> [Pokemon]
    
}

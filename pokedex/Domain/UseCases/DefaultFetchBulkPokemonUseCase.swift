

class DefaultFetchBulkPokemonUseCase: FetchBulkPokemonUseCase {
    
    private let repository: PokemonRepository
    
    init(repository: PokemonRepository) {
        self.repository = repository
    }
    
    func execute(range: ClosedRange<Int>) async throws -> [Pokemon] {
        return try await withThrowingTaskGroup { group in
        
            for i in range {
                group.addTask {
                    return try await self.repository.getPokemon(id: i)
                }
            }
            
            var results: [Pokemon] = []
            for try await result in group {
                results.append(result)
            }
            
            return results.sorted { $0.id < $1.id }
        }
    }
    
}

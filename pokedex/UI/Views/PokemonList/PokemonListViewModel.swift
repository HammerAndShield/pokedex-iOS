import Foundation
import Factory

@Observable
@MainActor
class PokemonListViewModel {
    struct uiState {
        var pokemons: [Pokemon] = []
    }
    
    @ObservationIgnored
    @Injected(\.fetchBulkPokemonUseCase)
    private var fetchBulkPokemonUseCase: FetchBulkPokemonUseCase

    var state = uiState()
        
    func onFetchPokemons() async {
        do {
            let newMons = try await fetchBulkPokemonUseCase.execute(range: 1...151)
            state.pokemons.append(contentsOf: newMons)
        } catch let err {
            print("error getting pokemon: \(err)")
        }
    }
    
}


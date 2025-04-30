import Foundation
import Factory

@Observable
@MainActor
class PokemonListViewModel {
    struct UiState {
        var pokemonMetadata: [PokemonMetadata] = []
        var pokemons: [Pokemon] = []
        var loading: Bool = true
    }
    
    @ObservationIgnored
    @Injected(\.pokemonRepository)
    private var pokemonRepo: PokemonRepository

    var state = UiState()
    
    private func getAllPokemonMetadata() async {
        do {
            let metadata = try await pokemonRepo.getPokemonList(limit: 1302)
        } catch let err {
            print("error getting metadata: \(err)")
        }
    }
        
    func onFetchPokemons() async {
        do {
            let newMons = try await pokemonRepo.getBulkPokemonById(range: 1...151)
            state.pokemons.append(contentsOf: newMons)
        } catch let err {
            print("error getting pokemon: \(err)")
        }
    }
    
}


import Foundation
import Factory

@Observable
@MainActor
class PokemonListViewModel {
    struct State {
        var pokemons: [Pokemon] = []
        var isLoading: Bool = false
        var canLoadMore: Bool = true
        var searchText: String = ""
        var errorMessage: String? = nil
    }
    
    @ObservationIgnored @Injected(\.pokemonService) private var pokemonRepo: PokemonServiceProtocol

    var state = State()
    
    private var allPokemonMetadata: [PokemonMetadata] = []
    private var allPokemons: [Pokemon] = []
    private var searchPokemons: [Pokemon] = []
    private var searchTask: Task<Void, Never>? = nil
    
    private let maxPokemonId: Int = 1025
    private let pageSize: Int = 30
    private var nextPageOffset: Int = 0
    
    func initialize() async {
        do {
            state.isLoading = true
            let metadata = try await pokemonRepo.getPokemonList(limit: maxPokemonId)
            state.isLoading = false
            allPokemonMetadata = metadata
            
            await onFetchPokemons()
        } catch let err {
            print("error getting metadata: \(err)")
        }
    }
    
    deinit {
        Task { @MainActor [weak self] in
            self?.searchTask?.cancel()
        }
    }
    
    func onSearchPokemon(_ text: String) async {
        state.searchText = text
        if text == "" {
            state.pokemons = allPokemons
            searchTask?.cancel()
            searchPokemons.removeAll()
        } else {
            state.pokemons = searchPokemons
            searchTask?.cancel()
            searchTask = Task {
                try? await Task.sleep(for: .milliseconds(300))
            }
        }
    }
        
    func onFetchPokemons() async {
        guard !state.isLoading && state.canLoadMore else { return }
        
        state.errorMessage = nil
        state.isLoading = true
        defer { state.isLoading = false }
        
        let endRange = min(nextPageOffset + pageSize-1, allPokemonMetadata.count)
        let ids = allPokemonMetadata[nextPageOffset..<endRange].map { $0.id }
        
        do {
            let newMons = try await fetchMorePokemons(ids: ids)
            state.pokemons.append(contentsOf: newMons)
            
            if endRange == maxPokemonId {
                state.canLoadMore = false
            }
            nextPageOffset = endRange + 1
        } catch let err {
            print("error getting pokemon: \(err)")
            state.errorMessage = "Oh no! Something went wrong. Try again later."
        }
    }
    
    private func fetchMorePokemons(ids: [Int]) async throws(PokemonError) -> [Pokemon] {
        return try await pokemonRepo.getBulkPokemonById(ids: ids)
    }
    
}


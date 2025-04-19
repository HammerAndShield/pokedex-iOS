import Foundation

@Observable
@MainActor
class PokemonListViewModel {
    
    private let repo = PokemonReposiotry()
    
    func onFetchPokemons() async {
        let pokemon = try? await repo.getPokemon(id: 2)
        print("received pokemon: \(pokemon?.name ?? "not found").")
    }
    
}


import Foundation

@Observable
@MainActor
class PokemonListViewModel {
    
    private let repo = PokemonReposiotry()
    private var idCounter = 1
    
    var curMon: Pokemon?
    
    func onFetchPokemons() async {
        do {
            let pokemon = try await repo.getPokemon(id: idCounter)
            print("received pokemon: \(pokemon).")
            curMon = pokemon
            idCounter += 1
        } catch let err {
            print("error getting pokemon: \(err)")
        }
    }
    
}


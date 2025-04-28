import SwiftUI

struct PokemonListView: View {
    
    @State var vm = PokemonListViewModel()
    
    var body: some View {
        PokemonListContentView(pokemons: vm.state.pokemons)
            .task {
                await vm.onFetchPokemons()
            }
    }
}

fileprivate struct PokemonListContentView: View {
    
    var pokemons: [Pokemon]
    
    private var gridColumns: [GridItem] {
        [
            GridItem(.adaptive(minimum: 150), spacing: 16)
        ]
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridColumns, spacing: 16) {
                ForEach(pokemons) { pokemon in
                    PokemonCard(pokemon: pokemon)
                }
            }
            .padding()
        }
        .background() {
            pokemonNavyBlue
                .ignoresSafeArea()
        }
    }
}

#Preview {
    let pokemons = Array(repeating: PreviewPokemon, count: 50)
    
    PokemonListContentView(pokemons: pokemons)
}

import SwiftUI

struct PokemonListView: View {
    
    @State var vm = PokemonListViewModel()
    
    var body: some View {
        PokemonListContentView(state: vm.state)
            .task {
                await vm.onFetchPokemons()
            }
            .navigationTitle("Pokedex")
    }
}

fileprivate struct PokemonListContentView: View {
    
    var state: PokemonListViewModel.UiState
    
    private var gridColumns: [GridItem] {
        [
            GridItem(.adaptive(minimum: 150), spacing: 16)
        ]
    }
    
    var body: some View {
        ZStack {
            pokemonNavyBlue
                .ignoresSafeArea()
            
            if state.loading {
                
            } else {
                ScrollView {
                    LazyVGrid(columns: gridColumns, spacing: 16) {
                        ForEach(state.pokemons) { pokemon in
                            PokemonCard(pokemon: pokemon)
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    let pokemons = Array(repeating: PreviewPokemon, count: 50)
    let state = PokemonListViewModel.UiState(pokemons: pokemons, loading: false)
    
    PokemonListContentView(state: state)
}

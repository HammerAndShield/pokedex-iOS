import SwiftUI

struct PokemonListView: View {
    
    @State var vm = PokemonListViewModel()
    
    var body: some View {
        PokemonListContentView(
            state: vm.state,
            onLoadMore: vm.onFetchPokemons
        )
            .task {
                await vm.initialize()
            }
            .navigationTitle("Pokedex")
    }
}

fileprivate struct PokemonListContentView: View {
    
    var state: PokemonListViewModel.State
    var onLoadMore: () async -> Void
    
    private var gridColumns: [GridItem] {
        [
            GridItem(.adaptive(minimum: 150), spacing: 16)
        ]
    }
    
    var body: some View {
        ZStack {
            pokemonNavyBlue
                .ignoresSafeArea()
            
    
            ScrollView {
                LazyVStack {
                    LazyVGrid(columns: gridColumns, spacing: 16) {
                        ForEach(state.pokemons) { pokemon in
                            PokemonCard(pokemon: pokemon)
                        }
                    }
                    .padding()
                    
                    Group {
                        if state.isLoading {
                            ProgressView()
                                
                        } else if state.canLoadMore {
                            Color.clear
                                .frame(height: 1)
                                .onAppear {
                                    Task {
                                        await onLoadMore()
                                    }
                                }
                        }
                    }.padding(.bottom)
                }
            }
            
        }
    }
}

#Preview {
    PokemonListView()
}

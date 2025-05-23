import SwiftUI

struct PokemonListView: View {
    
    @State var vm = PokemonListViewModel()
    
    var body: some View {
        PokemonListContentView(
            state: vm.state,
            onLoadMore: vm.onFetchPokemons,
            onSearchPokemons: vm.onSearchPokemon
        )
            .task {
                await vm.initialize()
            }
    }
}

fileprivate struct PokemonListContentView: View {
    
    var state: PokemonListViewModel.State
    var onLoadMore: () async -> Void
    var onSearchPokemons: (String) async -> Void
    
    private var gridColumns: [GridItem] {
        [
            GridItem(.adaptive(minimum: 150), spacing: 16)
        ]
    }
    
    private var searchBinding: Binding<String> {
        Binding(
            get: {
                state.searchText
            },
            set: { newSearchText in
                Task {
                    await onSearchPokemons(newSearchText)
                }
            }
        )
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
            .navigationTitle("Pokedex")
            .toolbarTitleDisplayMode(.inlineLarge)
            .searchable(text: searchBinding, prompt: "Search Pokemon")
        }
    }
}

#Preview {
    let state = PokemonListViewModel.State(pokemons: getPreviewPokemon(), isLoading: false, canLoadMore: true)
    NavigationStack {
        PokemonListContentView(
            state: state,
            onLoadMore: { print("Preview: onLoadMore called") },
            onSearchPokemons: { _ in print("Preview: onSearchPokemons called") }
        )
    }
}

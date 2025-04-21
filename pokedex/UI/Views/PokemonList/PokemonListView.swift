


import SwiftUI

struct PokemonListView: View {
    
    @State var vm = PokemonListViewModel()
    
    var body: some View {
        VStack {
            List(vm.state.pokemons) { pokemon in
                HStack {
                    AsyncImage(url: pokemon.spriteURL) { img in
                        img
                            .resizable()
                    } placeholder: {
                        ProgressView()
                    }
                    
                    Text(pokemon.name)
                }
                .frame(height: 80)
            }
        }
        .padding()
    }
}

#Preview {
    PokemonListView()
}




import SwiftUI

struct PokemonListView: View {
    
    @State var vm = PokemonListViewModel()
    
    var body: some View {
        VStack {
            if let pokemon = vm.curMon {
                AsyncImage(url: URL(string: pokemon.sprites.frontDefault)) { image in
                    image
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                } placeholder: {
                    ProgressView()
                }
                Text(pokemon.name)
            }
            Button("Get Some Mons") {
                Task {
                    await vm.onFetchPokemons()
                }
            }
            .frame(width: 200, height: 50)
            .background(Color.green)
            .foregroundStyle(Color.white)
            .clipShape(.capsule)
        }
        .padding()

    }
}

#Preview {
    PokemonListView()
}

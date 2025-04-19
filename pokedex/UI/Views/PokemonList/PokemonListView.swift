


import SwiftUI

struct PokemonListView: View {
    
    @State var vm = PokemonListViewModel()
    
    var body: some View {
        VStack {
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


import SwiftUI
import Foundation


struct PokemonCard: View {
    
    let pokemon: Pokemon
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack(alignment: .topLeading) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(pokemon.type.color.mix(with: .white, by: 0.2))
                    
                    AsyncImage(url: pokemon.spriteURL) { img in
                        img
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                }
                .padding(4)
                
                
                Text(pokemon.idString)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
                    .padding(6)
                    .background(
                        UnevenRoundedRectangle(cornerRadii: .init(topLeading: 10))
                            .fill(pokemon.type.color)
                    )
            }
            .aspectRatio(1, contentMode: .fit)
            
            
            Text(pokemon.name)
                .font(.headline)
                .foregroundStyle(.white)
                .padding(.bottom)
        }
        .background(RoundedRectangle(cornerRadius: 10).fill(pokemon.type.color))
        .padding()
    }
    
}

#Preview {
    let pokemon = PreviewPokemon
    VStack {
        PokemonCard(pokemon: pokemon)
    }
    .frame(width: 200, height: 200)
}

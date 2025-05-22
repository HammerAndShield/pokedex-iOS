import Foundation

let PreviewPokemon = Pokemon(name: "Charmander", id: 4, spriteURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png")!, type: .fire)

func getPreviewPokemon() -> [Pokemon] {
    var pokeList = [Pokemon]()
    for i in 1...10 {
        pokeList.append(Pokemon(name: PreviewPokemon.name, id: i, spriteURL: PreviewPokemon.spriteURL, type: PreviewPokemon.type))
    }
    return pokeList
}

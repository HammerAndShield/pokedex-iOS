import Foundation

struct Pokemon: Identifiable {
    
    let name: String
    let id: Int
    let spriteURL: URL
    let type: PokeType
    
    var idString: String {
        switch id {
        case 1..<10:
            return "00\(id)"
        case 10..<100:
            return "0\(id)"
        default:
            return "\(id)"
        }
    }
    
}


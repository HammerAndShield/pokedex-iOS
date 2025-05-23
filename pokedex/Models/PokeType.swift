import SwiftUI

enum PokeType: String, CaseIterable {
    case fire
    case water
    case grass
    case poison
    case electric
    case fairy
    case rock
    case steel
    case normal
    case fighting
    case flying
    case ground
    case psychic
    case bug
    case ice
    case dragon
    case ghost
    case dark
    
    case unknown
    
    static func fromString(_ string: String) -> PokeType {
        return PokeType(rawValue: string.lowercased()) ?? .unknown
    }
    
    var color: Color {
        switch self {
        case .fire:
            return Color(.sRGB, red: 0.9, green: 0.3, blue: 0.3, opacity: 1.0)
        case .water:
            return Color(.sRGB, red: 0.3, green: 0.5, blue: 0.9, opacity: 1.0)
        case .grass:
            return Color(.sRGB, red: 0.3, green: 0.8, blue: 0.3, opacity: 1.0)
        case .poison:
            return Color(.sRGB, red: 0.6, green: 0.3, blue: 0.6, opacity: 1.0)
        case .electric:
            return Color(.sRGB, red: 1.0, green: 0.85, blue: 0.3, opacity: 1.0)
        case .fairy:
            return Color(.sRGB, red: 0.9, green: 0.6, blue: 0.8, opacity: 1.0)
        case .rock:
            return Color(.sRGB, red: 0.7, green: 0.6, blue: 0.4, opacity: 1.0)
        case .steel:
            return Color(.sRGB, red: 0.6, green: 0.6, blue: 0.7, opacity: 1.0)
        case .normal:
            return Color(.sRGB, red: 0.7, green: 0.7, blue: 0.6, opacity: 1.0)
        case .fighting:
            return Color(.sRGB, red: 0.8, green: 0.3, blue: 0.3, opacity: 1.0)
        case .flying:
            return Color(.sRGB, red: 0.7, green: 0.6, blue: 0.9, opacity: 1.0)
        case .ground:
            return Color(.sRGB, red: 0.8, green: 0.7, blue: 0.4, opacity: 1.0)
        case .psychic:
            return Color(.sRGB, red: 1.0, green: 0.4, blue: 0.6, opacity: 1.0)
        case .bug:
            return Color(.sRGB, red: 0.7, green: 0.8, blue: 0.3, opacity: 1.0)
        case .ice:
            return Color(.sRGB, red: 0.6, green: 0.9, blue: 0.9, opacity: 1.0)
        case .dragon:
            return Color(.sRGB, red: 0.5, green: 0.3, blue: 0.9, opacity: 1.0)
        case .ghost:
            return Color(.sRGB, red: 0.5, green: 0.4, blue: 0.7, opacity: 1.0)
        case .dark:
            return Color(.sRGB, red: 0.5, green: 0.4, blue: 0.4, opacity: 1.0)
        case .unknown:
            return Color.gray
        }
    }
}


import Foundation

struct Pokemon: Identifiable, Decodable {
    let id: Int
    let name: String
    let sprites: Sprites
    let types: [TypeElement]
    let height: Int
    let weight: Int
    let abilities: [AbilityElement]
    let stats: [Stat]
    
    var formattedHeight: String {
        return String(format: "%.1f m", Float(height) / 10)
    }
    
    var formattedWeight: String {
        return String(format: "%.1f kg", Float(weight) / 10)
    }
}

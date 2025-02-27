import Foundation

struct AbilityElement: Decodable {
    let ability: Species
    let isHidden: Bool
    
    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
    }
}

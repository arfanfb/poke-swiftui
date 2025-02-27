import Foundation

struct PokemonListItem: Identifiable, Decodable {
    let name: String
    let url: String
    
    var id: String {
        name
    }
    
    // Extract the pokemon ID from the URL to create the image URL
    var imageURL: String {
        if let urlComponents = URLComponents(string: url),
           let pathComponents = urlComponents.path.components(separatedBy: "/").dropLast().last,
           let idString = Int(pathComponents) {
            return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(idString).png"
        }
        return ""
    }
    
    var pokemonId: Int? {
        if let urlComponents = URLComponents(string: url),
           let pathComponents = urlComponents.path.components(separatedBy: "/").dropLast().last,
           let idString = Int(pathComponents) {
            return idString
        }
        return nil
    }
}

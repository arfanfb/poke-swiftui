import Foundation
//
//  PokemonAPI.swift
//  poke
//
//  Created by Arfan on 27/02/25.
//

class PokemonAPI {
    static let shared = PokemonAPI()
    private let baseURL = "https://pokeapi.co/api/v2/"
    
    func fetchPokemonList(limit: Int = 151, completion: @escaping (Result<PokemonList, Error>) -> Void) {
        let urlString = "\(baseURL)pokemon?limit=\(limit)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let pokemonList = try JSONDecoder().decode(PokemonList.self, from: data)
                completion(.success(pokemonList))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchPokemonDetail(id: Int, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        let urlString = "\(baseURL)pokemon/\(id)"
        guard let url = URL(string: urlString) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                completion(.success(pokemon))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}

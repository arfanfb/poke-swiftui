import Foundation
//
//  PokemonListViewModel.swift
//  poke
//
//  Created by Arfan on 27/02/25.
//


class PokemonListViewModel: ObservableObject {
    @Published var pokemonList: [PokemonListItem] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    func fetchPokemonList() {
        isLoading = true
        errorMessage = nil
        
        PokemonAPI.shared.fetchPokemonList { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let pokemonList):
                    self?.pokemonList = pokemonList.results
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

import Foundation
//
//  PokemonDetailViewModel.swift
//  poke
//
//  Created by Arfan on 27/02/25.
//
import SwiftUI

class PokemonDetailViewModel: ObservableObject {
    @Published var pokemon: Pokemon?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var currentPokemonId: Int
    @Published var isFavorite: Bool = false

    init(pokemonId: Int) {
        self.currentPokemonId = pokemonId
    }

    func fetchPokemonDetail() {
        isLoading = true
        errorMessage = nil

        PokemonAPI.shared.fetchPokemonDetail(id: currentPokemonId) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false

                switch result {
                case .success(let pokemon):
                    withAnimation {
                        self?.pokemon = pokemon
                        self?.isFavorite = self?.checkIfFavorite(pokemonId: pokemon.id) ?? false
                    }
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func nextPokemon() {
        currentPokemonId += 1
        fetchPokemonDetail()
    }

    func previousPokemon() {
        if currentPokemonId > 1 {
            currentPokemonId -= 1
            fetchPokemonDetail()
        }
    }

    func toggleFavorite() {
        isFavorite.toggle()
        saveFavoriteStatus(pokemonId: currentPokemonId, isFavorite: isFavorite)
    }

    private func checkIfFavorite(pokemonId: Int) -> Bool {
        return UserDefaults.standard.bool(forKey: "favorite_\(pokemonId)")
    }

    private func saveFavoriteStatus(pokemonId: Int, isFavorite: Bool) {
        UserDefaults.standard.set(isFavorite, forKey: "favorite_\(pokemonId)")
    }
}

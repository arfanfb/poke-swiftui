//
//  FavoritePokemonListViewModel.swift
//  poke
//
//  Created by Arfan on 28/02/25.
//
import SwiftUI

class FavoritePokemonListViewModel: ObservableObject {
    @Published var favoritePokemonList: [PokemonListItem] = []
    private var allPokemonList: [PokemonListItem]

    init(pokemonList: [PokemonListItem]) {
        self.allPokemonList = pokemonList
        loadFavoritePokemon()
    }

    func loadFavoritePokemon() {
        favoritePokemonList = allPokemonList.enumerated().filter { index, pokemon in
            UserDefaults.standard.bool(forKey: "favorite_\(index + 1)")
        }.map { $0.element }
    }

    func updatePokemonList(_ newList: [PokemonListItem]) {
        self.allPokemonList = newList
        loadFavoritePokemon()
    }
}

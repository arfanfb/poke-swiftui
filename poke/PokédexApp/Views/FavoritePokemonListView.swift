//
//  FavoritePokemonListView.swift
//  poke
//
//  Created by Arfan on 28/02/25.
//
import SwiftUI

struct FavoritePokemonListView: View {
    @StateObject private var viewModel: FavoritePokemonListViewModel
    private var pokemonList: [PokemonListItem]

    init(pokemonList: [PokemonListItem]) {
        self.pokemonList = pokemonList
        _viewModel = StateObject(wrappedValue: FavoritePokemonListViewModel(pokemonList: pokemonList))
    }

    var body: some View {
        List(viewModel.favoritePokemonList) { pokemon in
            NavigationLink(destination: PokemonDetailView(pokemonId: pokemon.pokemonId ?? 1)) {
                HStack {
                    AsyncImage(url: URL(string: pokemon.imageURL)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 50, height: 50)
                    }

                    Text(pokemon.name.capitalized)
                        .font(.headline)

                    Spacer()

                    if let id = pokemon.pokemonId {
                        Text("#\(String(format: "%03d", id))")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.vertical, 4)
            }
        }
        .navigationTitle("Favorites")
        .onAppear {
            viewModel.updatePokemonList(pokemonList)
        }
    }
}

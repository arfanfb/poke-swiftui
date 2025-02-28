import SwiftUI
//
//  PokemonListView.swift
//  poke
//
//  Created by Arfan on 27/02/25.
//
struct PokemonListView: View {
    @StateObject private var viewModel = PokemonListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .listRowSeparator(.hidden)
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .listRowSeparator(.hidden)
                } else {
                    ForEach(viewModel.pokemonList) { pokemon in
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
                }
            }
            .navigationTitle("Pokédex")            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: FavoritePokemonListView(pokemonList: viewModel.pokemonList)) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                            .font(.title)
                    }
                }
            }
            .onAppear {
                if viewModel.pokemonList.isEmpty {
                    viewModel.fetchPokemonList()
                }
            }
            .refreshable {
                viewModel.fetchPokemonList()
            }
        }
    }
}

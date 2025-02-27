import SwiftUI

//
//  PokemonDetailView.swift
//  poke
//
//  Created by Arfan on 27/02/25.
//
import SwiftUI

struct PokemonDetailView: View {
    @StateObject private var viewModel: PokemonDetailViewModel

    init(pokemonId: Int) {
        _viewModel = StateObject(wrappedValue: PokemonDetailViewModel(pokemonId: pokemonId))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else if let pokemon = viewModel.pokemon {
                    // Favorite button
                    HStack {
                        Button(action: {
                            viewModel.toggleFavorite()
                        }) {
                            Text(viewModel.isFavorite ? "Favorite" : "Add to Favorite")
                                .font(.subheadline)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(viewModel.isFavorite ? Color.pink : Color.gray)
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                        }
                    }

                    // Pokemon image
                    AsyncImage(url: URL(string: pokemon.sprites.frontDefault)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                            .background(typeColor(for: pokemon.types.first?.type.name ?? ""))
                            .clipShape(Circle())
                            .overlay(
                                Circle()
                                    .stroke(Color.white, lineWidth: 4)
                                    .shadow(radius: 7)
                            )
                    } placeholder: {
                        ProgressView()
                            .frame(width: 200, height: 200)
                    }
                    .padding(.top)

                    // Pokemon name and number
                    Text("\(pokemon.name.capitalized) #\(String(format: "%03d", pokemon.id))")
                        .font(.title)
                        .fontWeight(.bold)

                    // Types
                    HStack {
                        ForEach(pokemon.types, id: \.type.name) { typeElement in
                            Text(typeElement.type.name.capitalized)
                                .font(.subheadline)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 8)
                                .background(typeColor(for: typeElement.type.name))
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                        }
                    }

                    // Physical attributes
                    HStack(spacing: 30) {
                        VStack {
                            Text("Height")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(pokemon.formattedHeight)
                                .font(.title3)
                        }

                        VStack {
                            Text("Weight")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(pokemon.formattedWeight)
                                .font(.title3)
                        }
                    }
                    .padding()
                    .background(Color.secondary.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                    // Abilities
                    VStack(alignment: .leading) {
                        Text("Abilities")
                            .font(.headline)
                            .padding(.bottom, 4)

                        ForEach(pokemon.abilities, id: \.ability.name) { abilityElement in
                            HStack {
                                Text(abilityElement.ability.name.capitalized)
                                    .font(.subheadline)

                                if abilityElement.isHidden {
                                    Text("(Hidden)")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.vertical, 2)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.secondary.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                    // Stats
                    VStack(alignment: .leading) {
                        Text("Base Stats")
                            .font(.headline)
                            .padding(.bottom, 4)

                        ForEach(pokemon.stats, id: \.stat.name) { stat in

                            HStack {

                                Text(formatStatName(stat.stat.name))
                                    .font(.subheadline)
                                    .frame(width: 120, alignment: .leading)

                                Text("\(stat.baseStat)")
                                    .font(.subheadline)
                                    .frame(width: 40)

                                ProgressView(value: Double(stat.baseStat), total: 255)
                                    .tint(statColor(for: stat.baseStat))
                                    .progressViewStyle(.linear)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.secondary.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
            }
            .padding()
            .transition(.slide)
        }
        .onAppear {
            if #available(iOS 16.0, *) {
                UIScrollView.appearance().showsVerticalScrollIndicator = false
                UIScrollView.appearance().showsHorizontalScrollIndicator = false
            }
        }
        .onDisappear {
            if #available(iOS 16.0, *) {
                UIScrollView.appearance().showsVerticalScrollIndicator = true
                UIScrollView.appearance().showsHorizontalScrollIndicator = true
            }
        }
        .navigationTitle(viewModel.pokemon?.name.capitalized ?? "Pokemon Details")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            viewModel.fetchPokemonDetail()
        }
        .gesture(
            DragGesture()
                .onEnded { value in
                    if value.translation.width < 0 {
                        viewModel.nextPokemon()
                    } else if value.translation.width > 0 {
                        viewModel.previousPokemon()
                    }
                }
        )
    }    
}

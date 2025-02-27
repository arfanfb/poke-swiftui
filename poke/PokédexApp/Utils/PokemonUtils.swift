import SwiftUI
//
//  PokemonUtils.swift
//  poke
//
//  Created by Arfan on 27/02/25.
//

func formatStatName(_ name: String) -> String {
    switch name {
    case "hp":
        return "HP"
    case "attack":
        return "Attack"
    case "defense":
        return "Defense"
    case "special-attack":
        return "Sp. Attack"
    case "special-defense":
        return "Sp. Defense"
    case "speed":
        return "Speed"
    default:
        return name.capitalized
    }
}

func typeColor(for type: String) -> Color {
    switch type {
    case "fire":
        return Color.red
    case "water":
        return Color.blue
    case "grass":
        return Color.green
    case "electric":
        return Color.yellow
    case "ice":
        return Color(red: 0.5, green: 0.8, blue: 1.0)
    case "fighting":
        return Color.orange
    case "poison":
        return Color.purple
    case "ground":
        return Color.brown
    case "flying":
        return Color(red: 0.6, green: 0.6, blue: 1.0)
    case "psychic":
        return Color.pink
    case "bug":
        return Color(red: 0.6, green: 0.8, blue: 0.2)
    case "rock":
        return Color(red: 0.7, green: 0.6, blue: 0.3)
    case "ghost":
        return Color(red: 0.4, green: 0.4, blue: 0.8)
    case "dragon":
        return Color(red: 0.4, green: 0.2, blue: 0.9)
    case "dark":
        return Color(red: 0.4, green: 0.3, blue: 0.3)
    case "steel":
        return Color(red: 0.6, green: 0.6, blue: 0.8)
    case "fairy":
        return Color(red: 1.0, green: 0.6, blue: 0.7)
    default:
        return Color.gray
    }
}

func statColor(for value: Int) -> Color {
    if value < 50 {
        return .red
    } else if value < 90 {
        return .orange
    } else if value < 120 {
        return .green
    } else {
        return .blue
    }
}

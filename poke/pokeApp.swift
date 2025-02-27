//
//  pokeApp.swift
//  poke
//
//  Created by Arfan on 25/02/25.
//

import SwiftUI

// MARK: - App Entry Point
@main
struct PokemonApp: App {
    var body: some Scene {
        WindowGroup {
            PokemonListView()
        }
    }
}

# Pokédex App

This is a simple Pokédex app built using SwiftUI. It fetches data from the PokéAPI and displays a list of Pokémon with their details.

## Features

- **List of Pokémon**: Displays a list of Pokémon with their images and names.
- **Pokemon Details**: Shows detailed information about each Pokémon, including its image, types, height, weight, abilities, and base stats.
- **Loading Indicators**: Shows loading indicators while fetching data.
- **Error Handling**: Displays error messages if data fetching fails.
- **Pull to Refresh**: Allows refreshing the Pokémon list by pulling down.

## Data Models

- `Pokemon`: Represents a Pokémon with properties like id, name, sprites, types, height, weight, abilities, and stats.
- `Sprites`: Represents the sprite images of a Pokémon.
- `TypeElement`: Represents a type of a Pokémon.
- `AbilityElement`: Represents an ability of a Pokémon.
- `Species`: Represents a species with a name.
- `Stat`: Represents a base stat of a Pokémon.
- `PokemonList`: Represents a list of Pokémon.
- `PokemonListItem`: Represents a single Pokémon item in the list.

## API Service

- `PokemonAPI`: A singleton class that handles fetching data from the PokéAPI.
  - `fetchPokemonList(limit:completion:)`: Fetches a list of Pokémon.
  - `fetchPokemonDetail(id:completion:)`: Fetches detailed information about a specific Pokémon.

## View Models

- `PokemonListViewModel`: Manages the state and data for the Pokémon list view.
  - `fetchPokemonList()`: Fetches the list of Pokémon.
- `PokemonDetailViewModel`: Manages the state and data for the Pokémon detail view.
  - `fetchPokemonDetail(id:)`: Fetches detailed information about a specific Pokémon.

## SwiftUI Views

- `PokemonListView`: Displays the list of Pokémon.
- `PokemonDetailView`: Displays detailed information about a specific Pokémon.

## How to Run

1. Clone the repository.
2. Open the project in Xcode.
3. Build and run the app on a simulator or a physical device.

## Dependencies

- SwiftUI
- URLSession for network requests

## Screenshots

Include screenshots of the app here.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.

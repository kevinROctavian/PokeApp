//
//  PokemonDetail.swift
//  PokeApp
//
//  Created by Kevin Renata on 08/07/23.
//

import Foundation

struct PokemonDetailAPIDto: Decodable {
    let name: String
    let id: Int
    let sprites: Sprite
    let stats: [Stats]
    let height: Int
    let weight: Int
    let types: [Types]
    struct Sprite: Decodable {
        let front_default: String
        let back_default: String
        let back_female: String?
        let back_shiny: String
        let back_shiny_female: String?
        let front_female: String?
        let front_shiny: String
        let front_shiny_female: String?
    }
    struct Stats: Decodable {
        let base_stat: Int
        let effort: Int
        let stat: Stat

        struct Stat: Decodable {
            let name: String
            let url: String
        }
    }
    struct Types: Decodable {
        let slot: Int
        let type: TypeDetail

        struct TypeDetail: Decodable {
            let name: String
            let url: String
        }
        
        func toDomain() -> String {
            return type.name
        }
    }

    func toDomain() -> PokemonDetail {
        return .init(
            name: name,
            idPokemon: id,
            images: [sprites.front_default, sprites.back_default, sprites.back_female, sprites.back_shiny, sprites.back_shiny_female, sprites.front_female, sprites.front_shiny, sprites.front_shiny_female].compactMap { $0 },
            stats: stats.map { PokemonDetail.Stat(name: $0.stat.name, base: $0.base_stat)  },
            height: height,
            weight: weight,
            type: types.map { $0.toDomain()}
        )
    }
}

public struct PokemonDetail: Identifiable, Equatable {
    public let id = UUID()
    let name: String
    let idPokemon: Int
    let images: [String]
    let stats: [Stat]
    let height: Int
    let weight: Int
    let type: [String]
    
    public struct Stat {
        let name: String
        let base: Int
    }
}

extension PokemonDetail: Hashable {
    
    func getHeight() -> String{
        let pokemonHeight = Float(height) / 10.0
        return String(format: "%.2f", pokemonHeight)
    }
    
    func getWeight() -> String{
        let pokemonWeight = Float(weight) / 10.0
        return String(format: "%.2f", pokemonWeight)
    }
    
    func getType() -> String{
        var typeString = ""
        for t in type{
            typeString += "\(t.capitalized);"
        }
        return typeString
    }
    
}
extension PokemonDetail.Stat: Hashable {}

public struct PokemonDetailStoreDto: Codable, Equatable {
    let name: String
    let id: Int
    let images: [String]
    let stats: [StatStoreDto]
    let height: Int
    let weight: Int
    let types: [String]
    
    struct StatStoreDto: Codable, Equatable {
        let name: String
        let base: Int

        func toDomain() -> PokemonDetail.Stat {
            return .init(name: name, base: base)
        }
    }

    func toDomain() -> PokemonDetail {
        return .init(
            name: name,
            idPokemon: id,
            images: images,
            stats: stats.map { $0.toDomain() },
            height: height,
            weight: weight,
            type: types
        )
    }
}

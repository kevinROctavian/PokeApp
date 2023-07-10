//
//  PokemonList.swift
//  PokeApp
//
//  Created by Kevin Renata on 08/07/23.
//

import Foundation

struct PokemonListAPIDto: Decodable {
    let count: Int
    let next: String
    let results: [PokemonListAPIDto.PokemonIndividual]

    struct PokemonIndividual: Decodable {
        let name: String
        let url: String
    }

    func toDomain() -> [PokemonList] {
        return results.map { PokemonList(name: $0.name, url: $0.url) }
    }
}

struct PokemonList: Equatable {
    let name: String
    let url: String
}

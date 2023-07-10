//
//  PokemonStorageServiceMock.swift
//  PokeAppTests
//
//  Created by Kevin Renata on 10/07/23.
//

import Foundation
@testable import PokeApp

class PokemonStorageServiceMock: PokemonStorageServiceProtocol {
    func persist(pokemon: PokemonDetailStoreDto) { }

    func getPokemon() -> [PokemonDetailStoreDto] {
        return []
    }
}

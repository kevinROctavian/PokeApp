//
//  PokemonInteractorMock.swift
//  PokeAppTests
//
//  Created by Kevin Renata on 10/07/23.
//

import Foundation
@testable import PokeApp

class PokemonInteractorMock: PokemonInteractorProtocol {
    func getPokemon(completion: @escaping (Result<[PokemonDetail], Error>) -> Void) {
        completion(.success([pokemonDetail]))
    }
}


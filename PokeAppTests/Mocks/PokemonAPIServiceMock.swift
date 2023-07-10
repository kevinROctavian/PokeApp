//
//  PokemonAPIServiceMock.swift
//  PokeAppTests
//
//  Created by Kevin Renata on 10/07/23.
//

import Foundation
@testable import PokeApp

class PokemonApiServiceMock: PokemonApiServiceProtocol {
    func requestPokemonList(completion: @escaping (ApiResponse<PokemonListAPIDto>) -> Void) {
        let dto = (try? JSONDecoder().decode(PokemonListAPIDto.self, from: pokeList.data(using: .utf8)!))!
        completion(.success(.init(), dto))
    }

    func requestPokemonDetail(url: String, completion: @escaping (ApiResponse<PokemonDetailAPIDto>) -> Void) {
        let decoder = JSONDecoder()
        let dto = (try? decoder.decode(PokemonDetailAPIDto.self, from: bulbasaur.data(using: .utf8)!))!
        completion(.success(.init(), dto))
    }
}


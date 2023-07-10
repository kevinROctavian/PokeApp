//
//  PokemonDetailTests.swift
//  PokeAppTests
//
//  Created by Kevin Renata on 09/07/23.
//

import XCTest
@testable import PokeApp

class PokemonDetailTests: XCTestCase {
    func testDecodeList() {
        let decoder = JSONDecoder()
        XCTAssertNoThrow(try decoder.decode(PokemonDetailAPIDto.self, from: bulbasaur.data(using: .utf8)!))
    }

    func testMapList() {
        let decoder = JSONDecoder()
        let dto = try? decoder.decode(PokemonDetailAPIDto.self, from: bulbasaur.data(using: .utf8)!)
        XCTAssertEqual(dto!.toDomain().name, pokemonDetail.name)
        XCTAssertEqual(dto!.toDomain().idPokemon, pokemonDetail.idPokemon)
        XCTAssertEqual(dto!.toDomain().images, pokemonDetail.images)
        XCTAssertEqual(dto!.toDomain().type, pokemonDetail.type)
    }
}


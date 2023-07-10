//
//  PokemonListTest.swift
//  PokeAppTests
//
//  Created by Kevin Renata on 10/07/23.
//


import XCTest
@testable import PokeApp

class PokemonListTests: XCTestCase {
    func testDecodeList() {
        XCTAssertNoThrow(try JSONDecoder().decode(PokemonListAPIDto.self, from: pokeList.data(using: .utf8)!))
    }

    func testMapList() {
        let dto = try? JSONDecoder().decode(PokemonListAPIDto.self, from: pokeList.data(using: .utf8)!)
        XCTAssertEqual(dto?.toDomain(), pokemonList)
    }
}

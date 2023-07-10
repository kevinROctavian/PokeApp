//
//  PokemonInteractorTests.swift
//  PokeAppTests
//
//  Created by Kevin Renata on 10/07/23.
//

import XCTest
@testable import PokeApp

class PokemonInteractorTests: XCTestCase {

    var repository: PokemonRepositoryProtocol!
    var interactor: PokemonInteractor!

    override func setUpWithError() throws { }

    override func setUp() {
        repository = PokemonRepository(apiService: PokemonApiServiceMock(), storageService: PokemonStorageServiceMock())
        interactor = PokemonInteractor(repository: repository)
    }

    func testAllPokemon() {
        let expect = expectation(description: #function)
        interactor.getPokemon(completion: {
            switch $0 {
            case .success(let detail):
                let expectedResult = Array(repeating: pokemonDetail, count: 20)
                XCTAssertEqual(detail.count, expectedResult.count)
                XCTAssertEqual(detail[0].idPokemon, expectedResult[0].idPokemon)
                XCTAssertEqual(detail[1].name, expectedResult[1].name)
                XCTAssertEqual(detail[2].type, expectedResult[2].type)
                expect.fulfill()
            case .failure:
                XCTFail()
            }
        })
        waitForExpectations(timeout: 2.0)
    }
}


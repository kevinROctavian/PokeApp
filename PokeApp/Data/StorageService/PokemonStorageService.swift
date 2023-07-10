//
//  StorageService.swift
//  PokeApp
//
//  Created by Kevin Renata on 08/07/23.
//


import Foundation

protocol PokemonStorageServiceProtocol {
    func persist(pokemon: PokemonDetailStoreDto)
    func getPokemon() -> [PokemonDetailStoreDto]
}

final class PokemonStorageService {
    private let dataManager: DataManager

    init(dataManager: DataManager = DataManager()) {
        self.dataManager = dataManager
    }
}

extension PokemonStorageService: PokemonStorageServiceProtocol {
    func getPokemon() -> [PokemonDetailStoreDto] {
        let pokemon = try? dataManager.getPokemon()
        return pokemon ?? []
    }

    func persist(pokemon: PokemonDetailStoreDto) {
        dataManager.save(pokemon: pokemon)
    }
}

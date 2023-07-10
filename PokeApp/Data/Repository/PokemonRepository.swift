//
//  PokemonRepository.swift
//  PokeApp
//
//  Created by Kevin Renata on 09/07/23.
//

import Foundation

protocol PokemonRepositoryProtocol {
    func getPokemonList(completion: @escaping (Result<[PokemonList], Error>) -> Void)
    func getPokemonDetail(url: String, completion: @escaping (Result<PokemonDetail, Error>) -> Void)
    func getCachedPokemon() -> [PokemonDetail]
}

final class PokemonRepository {
    private let apiService: PokemonApiServiceProtocol
    private let storageService: PokemonStorageServiceProtocol
    init(
        apiService: PokemonApiServiceProtocol = PokemonApiService(),
        storageService: PokemonStorageServiceProtocol = PokemonStorageService()
    ) {
        self.apiService = apiService
        self.storageService = storageService
    }
}

extension PokemonRepository: PokemonRepositoryProtocol {

    func getCachedPokemon() -> [PokemonDetail] {
        storageService.getPokemon().map { $0.toDomain() }
    }

    func getPokemonList(completion: @escaping (Result<[PokemonList], Error>) -> Void) {
        apiService.requestPokemonList(completion: { apiResponse in
            switch apiResponse.result {
            case .success(let dto):
                completion(.success(dto.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func getPokemonDetail(url: String, completion: @escaping (Result<PokemonDetail, Error>) -> Void) {
        apiService.requestPokemonDetail(url: url, completion: { apiResponse in
            switch apiResponse.result {
            case .success(let dto):
                let storeDto = PokemonDetailStoreDto(
                    name: dto.name,
                    id: dto.id,
                    images: [dto.sprites.front_default, dto.sprites.back_default, dto.sprites.back_female, dto.sprites.back_shiny, dto.sprites.back_shiny_female, dto.sprites.front_female, dto.sprites.front_shiny, dto.sprites.front_shiny_female].compactMap { $0 },
                    stats: dto.stats.map { PokemonDetailStoreDto.StatStoreDto(name: $0.stat.name, base: $0.base_stat) },
                    height: dto.height,
                    weight: dto.weight,
                    types: dto.types.map { $0.toDomain() }
                )
                self.storageService.persist(pokemon: storeDto)
                completion(.success(dto.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}

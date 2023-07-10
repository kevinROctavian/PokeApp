//
//  PokemonIntercator.swift
//  PokeApp
//
//  Created by Kevin Renata on 09/07/23.
//

import Foundation

protocol PokemonInteractorProtocol {
    func getPokemon(completion: @escaping (Result<[PokemonDetail], Error>) -> Void)
    
}

class PokemonInteractor {
    private let repository: PokemonRepositoryProtocol
    
    init(
        repository: PokemonRepositoryProtocol = PokemonRepository()
    ) {
        self.repository = repository
    }
}

extension PokemonInteractor: PokemonInteractorProtocol {
    func getPokemon(completion: @escaping (Result<[PokemonDetail], Error>) -> Void) {
        
        let dispatchGroup = DispatchGroup()
        var pokemonArray: [PokemonDetail] = []
        
        let cachedPokemon = repository.getCachedPokemon()
        if !cachedPokemon.isEmpty {
            completion(.success(cachedPokemon))
        } else {
            repository.getPokemonList(completion: { result in
                switch result {
                case .success(let pokemonList):
                    for pokemon in pokemonList {
                        dispatchGroup.enter()
                        self.repository.getPokemonDetail(url: pokemon.url, completion: { detailResult in
                            switch detailResult {
                            case .success(let detail):
                                pokemonArray.append(detail)
                                dispatchGroup.leave()
                            case .failure:
                                break
                            }
                        })
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
                
                dispatchGroup.notify(queue: .main, execute: {
                    completion(.success(pokemonArray))
                })
            }
            )
        }
        
    }
}

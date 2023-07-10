//
//  SearchAPIService.swift
//  PokeApp
//
//  Created by Kevin Renata on 08/07/23.
//

import Foundation
import Alamofire

protocol PokemonApiServiceProtocol {
    func requestPokemonList(completion: @escaping (ApiResponse<PokemonListAPIDto>) -> Void)
    func requestPokemonDetail(url: String, completion: @escaping (ApiResponse<PokemonDetailAPIDto>) -> Void)
}

final class PokemonApiService: PokemonApiServiceProtocol {
    func requestPokemonList(completion: @escaping (ApiResponse<PokemonListAPIDto>) -> Void) {
        
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon/") else {
            completion(.failure(.init(), .generic))
            return
        }
        AF.request(url).responseDecodable(of: PokemonListAPIDto.self) { response in
            debugPrint(response)
            if let value = response.value {
                completion(.success(.init(), value))
            } else {
                completion(.failure(.init(), .generic))
            }
        }
    }
    
    func requestPokemonDetail(url: String, completion: @escaping (ApiResponse<PokemonDetailAPIDto>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.init(), .generic))
            return
        }
        AF.request(url).responseDecodable(of: PokemonDetailAPIDto.self) { response in
            debugPrint(response)
            if let value = response.value {
                completion(.success(.init(), value))
            } else {
                completion(.failure(.init(), .generic))
            }
        }
    }
}

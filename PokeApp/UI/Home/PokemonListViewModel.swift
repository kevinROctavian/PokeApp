//
//  PokemonListViewModel.swift
//  PokeApp
//
//  Created by Kevin Renata on 08/07/23.
//

import Foundation
import Combine

class PokemonListViewModel: ObservableObject{
    private let interactor: PokemonInteractorProtocol
    
    var pokemonPublisher: Published<[PokemonDetail]>.Publisher { $pokemon }
    
    @Published var pokemon: [PokemonDetail] = []
    @Published var shouldLoad: Bool = false
    @Published var shouldError: Bool = false
    
    private var downloadedPokemon: [PokemonDetail] = []
    private var cancellables: Set<AnyCancellable> = []
    
    init(interactor: PokemonInteractorProtocol = PokemonInteractor()) {
        self.interactor = interactor
    }
    
    func getData() {
        interactor.getPokemon(completion: { result in
            self.shouldLoad = true
            switch result {
            case .success(let pokemon):
                self.downloadedPokemon = pokemon.sorted(by: {$0.name < $1.name})
                self.pokemon = self.downloadedPokemon
                self.shouldError = false
                self.shouldLoad = false
            case .failure:
                self.shouldError = true
            }
        })
    }
}


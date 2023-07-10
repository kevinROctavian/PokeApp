//
//  PokemonList.swift
//  PokeApp
//
//  Created by Kevin Renata on 08/07/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokemonListView: View {
    @StateObject var vm = PokemonListViewModel()
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("DarkWhite")
                    .ignoresSafeArea()
                ScrollView {
                    LazyVGrid(columns: adaptiveColumns, spacing: 10) {
                        ForEach(vm.pokemon) { pokemon in
                            NavigationLink(destination: PokemonDetailView(pokemon: pokemon)
                            ) {
                                PokemonGridView(vm: vm, pokemon: pokemon)
                            }
                        }
                    }
                    .padding([.leading, .trailing], 10)
                    .animation(.easeInOut(duration: 0.3), value: vm.pokemon.count)
                }
            }
        }
        .onAppear {
            vm.getData()
        }
    }
}


struct PokemonGridView: View {
    let vm: PokemonListViewModel
    let pokemon: PokemonDetail
    let dimensions: Double = 140
    
    var body: some View {
        ZStack {
            Color(red: 14/255, green: 31/255, blue: 64/255)
            VStack {
                if let url = URL(string:pokemon.images[0]){
                    WebImage(url: url)
                        .indicator (.activity)
                        .transition(.fade(duration: 0.5))
                        .scaledToFit()
                }
                Text("\(pokemon.name.capitalized)")
                    .foregroundStyle(.white)
                    .padding(.bottom, 20)
                
            }.padding(.top)
        }
        .cornerRadius(10.0)
        .padding(.all, 5)
    }
}


#if DEBUG
struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
#endif

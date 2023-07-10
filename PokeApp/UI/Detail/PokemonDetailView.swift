//
//  PokemonDetailView.swift
//  PokeApp
//
//  Created by Kevin Renata on 09/07/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokemonDetailView: View {
    
    var pokemon: PokemonDetail
    
    var body: some View {
        ZStack {
            Color("DarkWhite")
            VStack{
                HeaderCardView(pokemon: pokemon).padding(.bottom, 20)
                ContentView(pokemon: pokemon)
                Spacer()
            }.padding([.leading, .trailing, .top], 10)
        }
    }
}

struct ContentView: View{
    var pokemon: PokemonDetail
    
    var body: some View{
        VStack(alignment: .leading) {
            Text("Habilidades")
                .foregroundStyle(Color("DarkBlue"))
                .font(.headline)
            Divider()
            ForEach(pokemon.stats, id: \.self) { stat in
                StatView(stat: stat)
            }
        }
    }
}

struct StatView: View{
    var stat: PokemonDetail.Stat
    
    var body: some View{
        HStack() {
            Text("\(stat.name.capitalized.replacing("-", with: " ")):")
                .foregroundStyle(.white)
            Spacer()
            Text("\(stat.base)")
                .foregroundStyle(.white)
        }
        .padding([.leading, .trailing], 15)
        .frame(maxWidth: .infinity, maxHeight: 30)
        .background(Color("DarkBlue"))
        .clipShape(RoundedRectangle(cornerRadius:10))
    }
}

struct HeaderCardView: View{
    
    var pokemon: PokemonDetail
    
    var body: some View{
        HStack(alignment: .center) {
            if let url = URL(string:pokemon.images[0]){
                WebImage(url: url)
                    .resizable()
                    .indicator (.activity)
                    .frame(width: 150.0, height: 150.0)
                    .transition(.fade(duration: 0.5))
                    .scaledToFill()
            }
            
            VStack(alignment: .leading){
                Text("\(pokemon.name.capitalized)")
                    .foregroundStyle(.white)
                    .font(.title3)
                    .padding(.bottom, 10)
                
                Text("Type: \(pokemon.getType())")
                    .foregroundStyle(.white)
                
                Text("Height: \(pokemon.getHeight())m")
                    .foregroundStyle(.white)
                
                Text("Weight: \(pokemon.getWeight())kg")
                    .foregroundStyle(.white)
            }.frame(maxWidth: 200.0)
            
        }
        .frame(maxWidth: .infinity)
        .background(Color("DarkBlue"))
        .clipShape(RoundedRectangle(cornerRadius:10))
    }
}


#if DEBUG
struct PokemonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let pokemon = PokemonDetail(
            name: "bulbasaur",
            idPokemon: 1,
            images: ["https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png"],
            stats: [
                PokemonDetail.Stat(name: "hp", base: 60),
                PokemonDetail.Stat(name: "attack", base: 62),
                PokemonDetail.Stat(name: "defense", base: 63),
                PokemonDetail.Stat(name: "speed", base: 60),
            ],
            height: 130, // hectogram
            weight: 10, // decimeters
            type: ["Electricty", "Poison"]
        )
        PokemonDetailView(pokemon: pokemon)
    }
}
#endif

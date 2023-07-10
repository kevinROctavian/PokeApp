//
//  RootView.swift
//  PokeApp
//
//  Created by Kevin Renata on 09/07/23.
//

import SwiftUI


struct RootView: View {
    
    @StateObject var vm = LoginViewModel()
    
    var body: some View {
        Group {
            if (vm.isLoggedIn){
                let context = CoreDataStack.shared.container.viewContext
                PokemonListView().environment(\.managedObjectContext, context)
            }else{
                LoginView().environmentObject(vm)
            }
        }
    }
}

//
//  LoginView.swift
//  PokeApp
//
//  Created by Kevin Renata on 08/07/23.
//

import SwiftUI
import GoogleSignInSwift
import GoogleSignIn

struct LoginView: View {
    
    @EnvironmentObject var vm: LoginViewModel
    
    var body: some View {
        ZStack {
            Color("DarkBlue")
                .ignoresSafeArea()
            VStack {
                Spacer()
                Image( "PokeLogo")
                Spacer()
                GoogleSignInButton(action: vm.handleSignInButton)
                    .frame(maxWidth: 150.0)
                if(vm.isLoggedIn){
                    Text("Berhasil Login")
                        .foregroundStyle(.white)
                }
                Spacer()
            }
        }.onOpenURL { url in
            GIDSignIn.sharedInstance.handle(url)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

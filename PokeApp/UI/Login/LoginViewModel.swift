//
//  LoginViewModel.swift
//  PokeApp
//
//  Created by Kevin Renata on 09/07/23.
//

import Foundation
import GoogleSignInSwift
import GoogleSignIn


class LoginViewModel: ObservableObject{
    
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""
    
    init(){
        check()
    }
    
    func check(){
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let error = error {
                self.errorMessage = "error: \(error.localizedDescription)"
            }
            self.checkStatus()
        }
    }
    
    func checkStatus(){
        self.isLoggedIn = GIDSignIn.sharedInstance.currentUser != nil
    }
    
    func handleSignInButton() {
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { result, error in
            self.check()
        }
    }
    
}

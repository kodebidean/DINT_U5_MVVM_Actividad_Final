//
//  AuthViewModel.swift
//  TMDBMovies
//
//  Created by user258285 on 3/1/25.
//

import SwiftUI
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var isUserLoggedOut = false
    @Published var loginErrorMessage: String?
    
    func login(email: String, password: String, completion: @escaping (Bool) -> Void) {
        FirebaseAuthManager.shared.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.isUserLoggedOut = false
                    completion(true)
                case .failure(let error):
                    self.loginErrorMessage = error.localizedDescription
                    completion(false)
                }
            }
        }
    }

    func register(email: String, password: String, completion: @escaping (Bool) -> Void) {
        FirebaseAuthManager.shared.register(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.isUserLoggedOut = false
                    completion(true)
                case .failure(let error):
                    self.loginErrorMessage = error.localizedDescription
                    completion(false)
                }
            }
        }
    }

    func logout() {
        FirebaseAuthManager.shared.logout()
        DispatchQueue.main.async {
            self.isUserLoggedOut = true
        }
    }
}

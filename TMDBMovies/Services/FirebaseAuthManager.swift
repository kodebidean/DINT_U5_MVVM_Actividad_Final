//
//  FirebaseAuthManager.swift
//  TMDBMovies
//
//  Created by Imanol MU on 2/28/25.
//

import FirebaseAuth

class FirebaseAuthManager {
    static let shared = FirebaseAuthManager()

    /// Iniciar sesión con Firebase y guardar en CoreData
    func login(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                CoreDataManager.shared.saveUser(email: email, uid: user.uid)
                completion(.success(user))
            }
        }
    }

    /// Registrar usuario en Firebase y guardarlo en CoreData
    func register(email: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                CoreDataManager.shared.saveUser(email: email, uid: user.uid)
                completion(.success(user))
            }
        }
    }

    /// Cerrar sesión en Firebase y eliminar usuario de CoreData
    func logout() {
        try? Auth.auth().signOut()
        CoreDataManager.shared.deleteUser()
    }
}



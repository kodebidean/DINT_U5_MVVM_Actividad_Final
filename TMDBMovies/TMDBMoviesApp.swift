//
//  TMDBMoviesApp.swift
//  TMDBMovies
//
//  Created by Imanol MU on 2/28/25.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()  // Inicializa Firebase
        return true
    }
}

@main
struct TMDBMoviesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @AppStorage("isLoggedIn") var isLoggedIn = false  // Controla la autenticación global

    init() {
        if CoreDataManager.shared.getCurrentUser() != nil {
            isLoggedIn = true  // Si hay un usuario en CoreData, inicia sesión automáticamente
        }
    }

    var body: some Scene {
        WindowGroup {
            
            // Mueve el NavigationView al nivel superior
            NavigationView {
                if isLoggedIn {
                    MovieListView()
                } else {
                    LoginView()
                }
            }
        }
    }
}

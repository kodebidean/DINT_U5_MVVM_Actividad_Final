//
//  TMDBMoviesApp.swift
//  TMDBMovies
//
//  Created by user258285 on 2/28/25.
//

import SwiftUI
import FirebaseCore

// AppDelegate para inicializar Firebase en SwiftUI
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()  // Inicializa Firebase
        return true
    }
}

@main
struct TMDBMoviesApp: App {
    // Registrar el AppDelegate para Firebase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @AppStorage("isLoggedIn") var isLoggedIn = false  // Controla la autenticación global

    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                NavigationView {
                    MovieListView()  // Muestra la lista de películas si está logueado
                }
            } else {
                NavigationView {
                    LoginView()  // Muestra el login si no está logueado
                }
            }
        }
    }
}

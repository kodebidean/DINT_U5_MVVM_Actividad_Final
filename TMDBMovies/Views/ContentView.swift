//
//  ContentView.swift
//  TMDBMovies
//
//  Created by Imanol MU on 3/2/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: LoginView()) {
                    Text("Ir a Iniciar Sesión")
                }
                NavigationLink(destination: RegisterView()) {
                    Text("Ir a Registrarse")
                }
            }
        }
    }
}

//
//  LoginView.swift
//  TMDBMovies
//
//  Created by Imanol MU on 2/28/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var showError = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Iniciar sesión")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 50)

            TextField("Correo", text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

            SecureField("Contraseña", text: $password)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

            if showError, let errorMessage = authViewModel.loginErrorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            Button(action: {
                authViewModel.login(email: email, password: password) { success in
                    if !success {
                        showError = true
                    }
                }
            }) {
                Text("Iniciar sesión")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }

            NavigationLink(destination: RegisterView()) {
                Text("¿No tienes una cuenta? Regístrate")
                    .foregroundColor(.blue)
                    .padding(.top, 20)
            }
        }
        .padding()
    }
}





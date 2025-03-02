//
//  RegisterView.swift
//  TMDBMovies
//
//  Created by Imanol MU on 2/28/25.
//

import SwiftUI

struct RegisterView: View {
    @StateObject private var authViewModel = AuthViewModel()
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var errorMessage: String?
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 20) {
            Text("Registrarse")
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

            SecureField("Confirmar contraseña", text: $confirmPassword)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }

            Button(action: register) {
                Text("Registrarse")
                    .bold()
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }

            Button("¿Ya tienes una cuenta? Inicia sesión") {
                presentationMode.wrappedValue.dismiss()
            }
            .foregroundColor(.blue)
            .padding(.top, 20)
        }
        .padding()
    }

    private func register() {
        guard password == confirmPassword else {
            errorMessage = "Las contraseñas no coinciden"
            return
        }

        authViewModel.register(email: email, password: password) { success in
            if success {
                presentationMode.wrappedValue.dismiss()
            } else {
                errorMessage = authViewModel.loginErrorMessage
            }
        }
    }
}


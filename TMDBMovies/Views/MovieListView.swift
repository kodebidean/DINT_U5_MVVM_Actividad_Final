//
//  MovieListView.swift
//  TMDBMovies
//
//  Created by user258285 on 2/28/25.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieViewModel()
    @AppStorage("isLoggedIn") private var isLoggedIn = true
    @State private var searchText = ""

    var filteredMovies: [Movie] {
        if searchText.isEmpty {
            return viewModel.movies
        } else {
            return viewModel.movies.filter { $0.title.lowercased().contains(searchText.lowercased()) }
        }
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color(.darkGray)
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    // Campo de búsqueda
                    TextField("Buscar películas...", text: $searchText)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .shadow(radius: 5)

                    // Grid de películas
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(filteredMovies) { movie in
                                NavigationLink(destination: MovieDetailView(movie: movie)) {
                                    VStack {
                                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath ?? "")")) { image in
                                            image.resizable()
                                                .scaledToFit()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(height: 250)
                                        .cornerRadius(10)
                                        .shadow(radius: 5)

                                        Text(movie.title)
                                            .font(.headline)
                                            .multilineTextAlignment(.center)
                                            .padding(.horizontal, 5)
                                            .padding(.bottom, 5)
                                            .background(Color(.systemGray4))
                                            .cornerRadius(10)
                                            .shadow(radius: 3)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .navigationTitle("Películas Populares")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: logout) {
                            Label("Logout", systemImage: "power")
                        }
                    }
                }
                .onAppear {
                    viewModel.fetchMovies()
                }
                .fullScreenCover(isPresented: Binding(
                    get: { !isLoggedIn },
                    set: { _ in }
                )) {
                    LoginView()
                }
            }
            .foregroundStyle(Color.black)
        }
        
    }

    private func logout() {
        FirebaseAuthManager.shared.logout()
        isLoggedIn = false
    }
}



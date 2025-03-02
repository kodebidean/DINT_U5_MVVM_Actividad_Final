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

                VStack(spacing:0) {
                    // Campo de búsqueda
                    TextField("Buscar películas...", text: $searchText)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.bottom,6)
                        .shadow(radius: 5)

                    // Grid de películas
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 32) {
                            ForEach(filteredMovies) { movie in
                                NavigationLink(destination: MovieDetailView(movie: movie)) {
                                    VStack(alignment: .leading, spacing: 2) {
                                        ZStack(alignment: .topTrailing) {
                                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath ?? "")")) { image in
                                                image.resizable()
                                                    .scaledToFit()
                                            } placeholder: {
                                                ProgressView()
                                            }
                                            .frame(height: 220)
                                            .cornerRadius(10)
                                            .shadow(radius: 5)
                                            
                                            
                                            ZStack {
                                                Circle()
                                                    .fill(Color.yellow)
                                                    .frame(width: 40, height: 40)
                                                Text(String(format: "%.1f", movie.voteAverage ?? 0.0))
                                                    .foregroundColor(.black)
                                                    .font(.caption)
                                                    .bold()
                                            }
                                            .offset(x: -2, y: 0) // Ajusta la posición del círculo
                                            
                                        }
                                        
                                        Text(movie.title)
                                            .font(.title3)
                                            .lineLimit(2)
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .frame(height: 60) // Altura fija para dos líneas
                                            .padding(.horizontal,4)
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
                                .foregroundStyle(Color.red)
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
            .foregroundStyle(Color.white)
        }
    }

    private func logout() {
        FirebaseAuthManager.shared.logout()
        isLoggedIn = false
    }
}


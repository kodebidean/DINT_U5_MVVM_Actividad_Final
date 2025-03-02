//
//  MovieListView.swift
//  TMDBMovies
//
//  Created by user258285 on 2/28/25.
//

import SwiftUI

struct MovieListView: View {
    @StateObject private var viewModel = MovieViewModel()
    @StateObject private var authViewModel = AuthViewModel()
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
            VStack {
                TextField("Buscar películas...", text: $searchText)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding(.horizontal)

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

                                    Text(movie.title)
                                        .font(.headline)
                                        .multilineTextAlignment(.center)
                                        .padding(.horizontal, 5)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Películas Populares")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: authViewModel.logout) {
                        Label("Logout", systemImage: "arrow.right.circle")
                    }
                }
            }
            .onAppear {
                viewModel.fetchMovies()
            }
            .fullScreenCover(isPresented: $authViewModel.isUserLoggedOut) {
                LoginView()
            }
        }
    }
}

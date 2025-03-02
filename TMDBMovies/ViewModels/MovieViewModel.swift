//
//  MovieViewModel.swift
//  TMDBMovies
//
//  Created by Imanol MU on 3/1/25.
//

import Foundation

class MovieViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let apiService = MovieAPIService.shared

    init() {
        fetchMovies()
    }

    /// Obtener películas desde la API y actualizar la UI
    func fetchMovies() {
        isLoading = true
        errorMessage = nil

        apiService.fetchMovies { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let movies):
                    self?.movies = movies
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

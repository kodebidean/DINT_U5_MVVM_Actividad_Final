//
//  MovieRepository.swift
//  TMDBMovies
//
//  Created by Imanol MU on 3/1/25.
//

import Foundation
import CoreData

class MovieRepository {
    static let shared = MovieRepository()
    private let apiService = MovieAPIService()
    private let coreDataManager = CoreDataManager.shared

    /// Obtener películas desde la API
    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        apiService.fetchMovies { result in
            switch result {
            case .success(let movies):
                completion(.success(movies))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    /// Guardar película en CoreData
    func saveMovie(_ movie: Movie) {
        let context = coreDataManager.persistentContainer.viewContext
        let movieEntity = MovieEntity(context: context)
        movieEntity.id = Int64(movie.id)
        movieEntity.title = movie.title
        movieEntity.posterPath = movie.posterPath
        movieEntity.releaseDate = movie.releaseDate
        movieEntity.voteAverage = movie.voteAverage!

        do {
            try context.save()
        } catch {
            print("Error guardando película: \(error)")
        }
    }

    /// Obtener películas guardadas en CoreData
    func getFavoriteMovies() -> [MovieEntity] {
        let context = coreDataManager.persistentContainer.viewContext
        let request: NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()

        do {
            return try context.fetch(request)
        } catch {
            print("Error obteniendo películas: \(error)")
            return []
        }
    }

    /// Eliminar película de favoritos
    func deleteMovie(_ movie: MovieEntity) {
        let context = coreDataManager.persistentContainer.viewContext
        context.delete(movie)
        try? context.save()
    }
}


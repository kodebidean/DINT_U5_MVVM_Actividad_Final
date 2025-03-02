//
//  MovieApiService.swift
//  TMDBMovies
//
//  Created by user258285 on 3/1/25.
//
import Foundation

class MovieAPIService {
    static let shared = MovieAPIService()
    
    private let baseURL = "https://api.themoviedb.org/3/movie/popular"

    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "api_key", value: Secrets.tmdbApiKey), // 🔥 API Key desde Secrets.swift
            URLQueryItem(name: "language", value: "es-ES"),
            URLQueryItem(name: "page", value: "1") // 🔥 Solo primera página
        ]

        guard let url = components.url else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = ["accept": "application/json"]

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "No data", code: 0, userInfo: nil)))
                }
                return
            }

            // 🔥 Verificación 1: Imprimir URL generada
            print("🔗 URL Request: \(url.absoluteString)")

            // 🔥 Verificación 2: Imprimir JSON recibido
            if let jsonString = String(data: data, encoding: .utf8) {
                print("📡 JSON Response:\n\(jsonString)")
            }

            do {
                // 🔥 Verificación 3: Decodificar correctamente accediendo a "results"
                let decodedResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedResponse.results))
                }
            } catch {
                // 🔥 Verificación 4: Mostrar errores detallados
                print("❌ Error decodificando JSON: \(error)")
                debugPrint(error)
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

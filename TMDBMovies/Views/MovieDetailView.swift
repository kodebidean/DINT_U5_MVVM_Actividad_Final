//
//  MovieDetailView.swift
//  TMDBMovies
//
//  Created by user258285 on 3/1/25.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Corregimos la carga de la imagen con la URL completa
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath ?? "")")) { image in
                    image.resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView() // Indicador de carga
                }
                .frame(maxWidth: .infinity, maxHeight: 400)
                .cornerRadius(12)
                .padding()

                // Información de la película
                Text(movie.title)
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)
                
                Text("📅 Estreno: \(movie.releaseDate ?? "Desconocido")")
                                    .foregroundColor(.gray)
                                    .font(.subheadline)
                                    .padding(.horizontal)

                Text("⭐ \(String(format: "%.1f", movie.voteAverage ?? 0.0))")
                    .foregroundColor(.yellow)
                    .font(.title2)
                    .padding(.horizontal)
                
                Text("Sinopsis")
                    .font(.footnote)
                    .padding(.top)
                    .padding(.horizontal)
                    .bold()
                
                Text(movie.overview)
                    .font(.body)
                    .padding(.horizontal)
            }
        }
        .navigationTitle("Detalles")
        .navigationBarTitleDisplayMode(.inline)
    }
}


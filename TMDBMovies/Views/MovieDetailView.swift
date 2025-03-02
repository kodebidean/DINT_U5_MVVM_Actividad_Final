//
//  MovieDetailView.swift
//  TMDBMovies
//
//  Created by Imanol MU on 3/1/25.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Imagen de la película
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.posterPath ?? "")")) { image in
                    image.resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: 400)
                        .cornerRadius(12)
                } placeholder: {
                    ProgressView()
                }

                // Información de la película
                Text(movie.title)
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)
                    .foregroundColor(.white)

                HStack {
                    Text("📅 Estreno: \(movie.releaseDate ?? "Desconocido")")
                        .foregroundColor(.brown)
                        .font(.subheadline)

                    Spacer()

                    Text("⭐ \(String(format: "%.1f", movie.voteAverage ?? 0.0))")
                        .foregroundColor(.yellow)
                        .font(.title2)
                }
                .padding(.horizontal)

                Text("Sinopsis")
                    .font(.headline)
                    .padding(.top, 16)
                    .padding(.horizontal)
                    .foregroundColor(.white)

                Text(movie.overview)
                    .font(.body)
                    .padding(.horizontal)
                    .padding(.top, 8)
                    .foregroundColor(.white)
            }
        }
        .navigationTitle("Detalles")
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(.darkGray))
    }
}


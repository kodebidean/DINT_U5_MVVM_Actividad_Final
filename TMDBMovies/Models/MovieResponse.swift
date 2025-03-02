//
//  MovieResponse.swift
//  TMDBMovies
//
//  Created by Imanol MU on 3/1/25.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}

//
//  MovieService.swift
//  StarWarsDemoApp
//
//  Created by Yannick Rietz on 10.12.23.
//

import Foundation

class MovieService {
    let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
}

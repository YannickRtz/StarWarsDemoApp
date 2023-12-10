//
//  MovieService.swift
//  StarWarsDemoApp
//
//  Created by Yannick Rietz on 10.12.23.
//

import Foundation
import Combine

// Note: This Service is not strictly necessary for this example
// I include it as an example of a way to structure
// business logic for common use cases
class MovieService {
    let movieRepository: MovieRepository
    
    init(movieRepository: MovieRepository) {
        self.movieRepository = movieRepository
    }
    
    func fetchMovies() ->  AnyPublisher<[Movie], Error> {
        return movieRepository.fetchMovies()
    }
}

//
//  MovieRepository.swift
//  StarWarsDemoApp
//
//  Created by Yannick Rietz on 10.12.23.
//

import Foundation
import Combine

protocol MovieRepository {
    func fetchMovies() -> AnyPublisher<[Movie], Error>
}

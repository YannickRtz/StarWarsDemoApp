//
//  AppContext.swift
//  StarWarsDemoApp
//
//  Created by Yannick Rietz on 10.12.23.
//

import Foundation

struct AppContext {
    let movieService: MovieService
}

extension AppContext {
    static func bootstrap() -> AppContext {
        let movieRepository = MovieRepositoryImpl()
        let movieService = MovieService(movieRepository: movieRepository)
        return AppContext(movieService: movieService)
    }
}

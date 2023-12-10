//
//  MovieRepository.swift
//  StarWarsDemoApp
//
//  Created by Yannick Rietz on 10.12.23.
//

import Foundation
import Combine

enum MovieError: Error {
    case runtimeError(String)
}

extension MovieError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case let .runtimeError(code): return code
        }
    }
}

class MovieRepositoryImpl: MovieRepository {
    func fetchMovies() -> AnyPublisher<[Movie], Error> {
        guard let url = URL(string: "https://swapi.dev/api/films") else {
            return Fail(error: MovieError.runtimeError("Unable to generate url"))
                .eraseToAnyPublisher()
        }
        return Future { promise in
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                DispatchQueue.main.async {
                    do {
                        guard let data = data else {
                            return promise(Result.failure(MovieError.runtimeError("Could not parse data")))
                        }
                        let jsonObj = try? JSONSerialization.jsonObject(with: data, options: [])
                        guard let jsonDict = jsonObj as? [String: Any] else {
                            return promise(Result.failure(MovieError.runtimeError("Could not parse json object")))
                        }
                        guard let moviesDicts = jsonDict["results"] as? [[String: Any]] else {
                            return promise(Result.failure(MovieError.runtimeError("Could not parse results")))
                        }
                        let swapiMovies: [SWAPIMovie] = try moviesDicts.map { m in
                            guard let movie = SWAPIMovie(json: m) else {
                                throw MovieError.runtimeError("Could not parse movie")
                            }
                            return movie
                        }
                        let movies = swapiMovies.map(self.mapDataModelToDomainModel(_:))
                        return promise(Result.success(movies))
                    } catch let error {
                        return promise(Result.failure(error))
                    }
                }
            }.resume()
        }.eraseToAnyPublisher()
    }
    
    func mapDataModelToDomainModel(_ swapiMovie: SWAPIMovie) -> Movie {
        Movie(title: swapiMovie.title,
              id: swapiMovie.episodeId,
              date: swapiMovie.releaseDate)
    }
}

//
//  MovieListViewModel.swift
//  StarWarsDemoApp
//
//  Created by Yannick Rietz on 10.12.23.
//

import Foundation
import Combine

class MovieListViewModel: ObservableObject {
    enum ViewState: Equatable {
        case moviesInitial
        case moviesLoading
        case moviesSuccess(movies: [Movie])
        case moviesFailure(reason: String)
    }
    
    let movieService: MovieService
    
    init(_ context: AppContext) {
        movieService = context.movieService
    }
    
    @Published var state = ViewState.moviesInitial
    private var cancelables = Set<AnyCancellable>()
    
    func fetchMovies() {
        state = .moviesLoading
        movieService.fetchMovies()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.state = .moviesFailure(reason: error.localizedDescription)
                }
            } receiveValue: { movies in
                self.state = .moviesSuccess(movies: movies)
            }
            .store(in: &cancelables)
    }
    
    func cancelFetch() {
        if (state != .moviesLoading) {
            return
        }
        cancelables.removeAll()
        state = .moviesInitial
    }
}

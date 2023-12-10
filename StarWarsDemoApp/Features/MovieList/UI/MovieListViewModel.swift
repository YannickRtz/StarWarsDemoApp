//
//  MovieListViewModel.swift
//  StarWarsDemoApp
//
//  Created by Yannick Rietz on 10.12.23.
//

import Foundation

class MovieListViewModel: ObservableObject {
    enum ViewState {
        case initial
        case loading
        case success(movies: [Movie])
        case failure(reason: String)
    }
    
    @Published var state = ViewState.initial
    
    func fetchMovies() {
        state = .loading
    }
}

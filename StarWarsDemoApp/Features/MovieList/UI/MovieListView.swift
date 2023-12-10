//
//  MovieListView.swift
//  StarWarsDemoApp
//
//  Created by Yannick Rietz on 10.12.23.
//

import SwiftUI

struct MovieListView: View {
    let context: AppContext
    @ObservedObject private var viewModel: MovieListViewModel
    
    init(_ context: AppContext) {
        self.context = context
        self.viewModel = MovieListViewModel()
    }
    var body: some View {
        NavigationStack {
            NavigationSplitView {
                switch viewModel.state {
                case .initial:
                    Button("Fetch Movies") {
                        viewModel.fetchMovies()
                    }
                    .buttonStyle(.borderedProminent)
                case .loading:
                    Text("Loading...")
                case let .failure(reason):
                    Text(reason)
                case let .success(movies):
                    Text("success") // TODO
                }
            } detail: {
                Text("Detail")
            }
            .navigationTitle("Movie List")
        }
    }
}

#Preview {
    MovieListView(AppContext.bootstrap())
}

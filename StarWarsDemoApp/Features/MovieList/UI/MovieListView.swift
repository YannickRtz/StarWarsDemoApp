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
    @State private var selectedMovie: Movie?    
    
    init(_ context: AppContext) {
        self.context = context
        self.viewModel = MovieListViewModel(context)
    }
    var body: some View {
            NavigationSplitView {
                switch viewModel.state {
                case .moviesInitial:
                    Button("Fetch Movies") {
                        viewModel.fetchMovies()
                    }
                    .buttonStyle(.borderedProminent)
                case .moviesLoading:
                    ProgressView()
                    Text("Loading...")
                        .padding()
                    Button("Cancel") {
                        viewModel.cancelFetch()
                    }
                case let .moviesFailure(reason):
                    Text(reason)
                        .padding()
                    Button("Retry") {
                        viewModel.fetchMovies()
                    }
                case let .moviesSuccess(movies):
                    List(movies, selection: $selectedMovie) { m in
                        NavigationLink(value: m) {
                            Text(m.title)
                        }
                    }
                }
            } detail: {
                // TODO: Move to its own View File
                if let selectedMovie {
                    Text("Details for \"\(selectedMovie.title)\"...")
                        .font(.headline)
                    Text("Released \(getYearReleased(selectedMovie))")
                } else {
                    Text("Choose a movie from the list")
                }
            }
            .navigationTitle("Star Wars Movies")
    }
    
    func getYearReleased(_ m: Movie) -> String {
        let cal = Calendar.current
        let year = cal.dateComponents([.year], from: m.date).year!
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        let number = NSNumber(value: year)
        return formatter.string(from: number)!
    }
}

#Preview {
    MovieListView(AppContext.bootstrap())
}

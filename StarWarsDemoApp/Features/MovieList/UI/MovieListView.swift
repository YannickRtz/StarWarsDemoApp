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
        self.viewModel = MovieListViewModel(context)
    }
    var body: some View {
        NavigationStack {
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
                    List(movies) { m in
                        HStack {
                            Text(m.title)
                            Spacer()
                            Text(getYearReleased(m))
                                .font(.caption)
                        }
                    }
                }
            } detail: {
                Text("Detail")
            }
            .navigationTitle("Star Wars Movies")
        }
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

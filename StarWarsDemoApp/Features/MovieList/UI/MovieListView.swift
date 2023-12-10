//
//  MovieListView.swift
//  StarWarsDemoApp
//
//  Created by Yannick Rietz on 10.12.23.
//

import SwiftUI

struct MovieListView: View {
    let context: AppContext
    
    init(_ context: AppContext) {
        self.context = context
    }
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    MovieListView(AppContext.bootstrap())
}

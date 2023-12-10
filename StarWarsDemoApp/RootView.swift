//
//  ContentView.swift
//  StarWarsDemoApp
//
//  Created by Yannick Rietz on 10.12.23.
//

import SwiftUI

enum Tab {
    case movieList
    case lightsabers
}

struct RootView: View {
    @State private var selectedTab: Tab = .movieList
    let context = AppContext.bootstrap()
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                MovieListView(context)
            }
            .tabItem {
                Label("Movie List", systemImage: "movieclapper.fill")
            }
            .tag(Tab.movieList)

            NavigationView {
                EmptyView() // TODO
            }
            .tabItem {
                Label("Feature 2", systemImage: "wrench.and.screwdriver")
            }
            .tag(Tab.lightsabers)
        }
    }
}

#Preview {
    RootView()
}

//
//  ContentView.swift
//  TMDBMovies
//
//  Created by user258285 on 2/28/25.
//

import SwiftUI

struct ContentView: View {
    @State private var isLoggedIn = false

    var body: some View {
        Group {
            if isLoggedIn {
                MovieListView()
            } else {
                LoginView()
            }
        }
        .onAppear {
            if CoreDataManager.shared.getCurrentUser() != nil {
                isLoggedIn = true
            }
        }
    }
}

#Preview {
    ContentView()
}

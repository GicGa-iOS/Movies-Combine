//
//  ContentView.swift
//  Movies+SwiftUI
//
//  Created by Giancarlo Castañeda Garcia on 18/03/22.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = PopularMoviesViewModel()

    var body: some View {
        PopularMoviesList(
            repos: viewModel.state.repos,
            isLoading: viewModel.state.canLoadNextPage,
            onScrolledAtBottom: viewModel.fetchMoviesNextPageIfPossible
        )
        .background(Color.black)
        .onAppear(perform: viewModel.fetchMoviesNextPageIfPossible)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

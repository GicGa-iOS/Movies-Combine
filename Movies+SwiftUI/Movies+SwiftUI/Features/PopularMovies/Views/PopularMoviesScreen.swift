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
        NavigationView{
            List{
                ForEach(viewModel.movies, id: \.id) { movie in
                    Text(movie.title)
                }
            }
            .navigationTitle("Popular movies")
            .navigationBarTitleDisplayMode(.automatic)
            .onAppear {
                fetchData()
            }
        }
    }

    private func fetchData() {
        viewModel.fetchMovies()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

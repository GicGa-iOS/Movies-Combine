//
//  MovieDetailScreen.swift
//  Movies+SwiftUI
//
//  Created by Giancarlo Castañeda Garcia on 22/03/22.
//

import SwiftUI

struct MovieDetailScreen: View {

    let movie: PopularMovieResult

    var body: some View {
        Text(movie.title ?? "")
    }
}

struct MovieDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailScreen(movie: Helper.makeResult())
    }
}

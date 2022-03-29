//
//  Movies_SwiftUIApp.swift
//  Movies+SwiftUI
//
//  Created by Giancarlo Castañeda Garcia on 18/03/22.
//

import SwiftUI

@main
struct Movies_SwiftUIApp: App {
    @StateObject var detailViewModel = MovieDetailViewModel(service: MovieDetailService(networkRequest: NativeRequestable()))
    @StateObject var searchViewModel = SearchViewModel(service: MultiSearchService(networkRequest: NativeRequestable()))
    @StateObject var genresViewModel = GenreModelsViewModel(service: GenreModelService(networkRequest: NativeRequestable()))
    var body: some Scene {
        WindowGroup {
            RootView {
                TabViewScreen()
                    .environmentObject(detailViewModel)
                    .environmentObject(searchViewModel)
                    .environmentObject(genresViewModel)
            }
        }
    }
}

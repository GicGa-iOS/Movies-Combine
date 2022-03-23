//
//  Movies_SwiftUIApp.swift
//  Movies+SwiftUI
//
//  Created by Giancarlo Castañeda Garcia on 18/03/22.
//

import SwiftUI

@main
struct Movies_SwiftUIApp: App {
    @StateObject var detailViewModel = MovieDetailViewModel()
    var body: some Scene {
        WindowGroup {
            RootView {
                TabViewScreen()
                    .environmentObject(detailViewModel)
            }
        }
    }
}

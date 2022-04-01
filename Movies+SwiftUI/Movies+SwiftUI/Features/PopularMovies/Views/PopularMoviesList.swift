import SwiftUI

struct PopularMoviesList: View {

    let repos: [PopularMovieResultModel]
    let isLoading: Bool
    let onScrolledAtBottom: () -> Void

    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns) {
                reposList
            }
            if isLoading {
                loadingIndicator
            }
        }
    }

    private var reposList: some View {
        ForEach(repos) { repo in
            PopularMovieRow(movie: repo)
                .frame(minHeight: 300)
                .onAppear {
                    if self.repos.last == repo {
                        self.onScrolledAtBottom()
                    }
                }
        }
    }

    private var loadingIndicator: some View {
        Spinner(style: .medium)
            .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
    }
}


struct PopularMoviesList_Previews: PreviewProvider {

    static var previews: some View {
        PopularMoviesList(repos: [Helper.makeResult(),Helper.makeResult(),Helper.makeResult()],
                          isLoading: true,
                          onScrolledAtBottom: {})
    }
}

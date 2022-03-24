import SwiftUI

struct PopularMoviesScreen: View {

    @StateObject
    private var viewModel = PopularMoviesViewModel(service: PopularMoviesService(networkRequest: NativeRequestable()))

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

struct PopularMoviesScreen_Previews: PreviewProvider {
    static var previews: some View {
        PopularMoviesScreen()
    }
}

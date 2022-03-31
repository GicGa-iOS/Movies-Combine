import SwiftUI

struct MovieDetailScreen: View {

    @EnvironmentObject var viewModel: MovieDetailViewModel
    @EnvironmentObject var genresViewModel: GenreModelsViewModel
    let movieId: Int

    var body: some View {

        ScrollView {
            VStack(alignment: .leading) {
                MovieDetailHeaderView()

                GenresView(useSpecificGenres: viewModel.GenreModels, enableGenreTapGesture: false, alignment: .center)

                Text("Overview")
                    .bold()
                    .padding(10)
                    .font(.title3)
                    .foregroundColor(.white)

                ExpandableText(viewModel.overview, lineLimit: 3)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 10))
                    .foregroundColor(.white)
                    .font(.body)

                if !viewModel.videos.isEmpty {
                    VideosListView(videos: viewModel.videos)
                        .padding(.top, 10)
                }
                if !viewModel.images.isEmpty {
                    Gallery()
                        .padding(.top, 10)
                }

            }
            .frame(maxWidth: .infinity)
            .onAppear {
                viewModel.movieId = movieId
            }
        }
        .background(Color.black)
        .navigationBarTitle("Movies")

    }
}

struct MovieDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailScreen(movieId: 568124)
            .environmentObject(MovieDetailViewModel(service: MovieDetailService(networkRequest: NativeRequestable())))
            .environmentObject(
                GenreModelsViewModel(
                    service: GenreModelService(
                        networkRequest: NativeRequestable()
                    )
                )
            )
    }
}

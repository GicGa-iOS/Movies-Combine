import SwiftUI

struct MovieDetailScreen: View {

    @EnvironmentObject var viewModel: MovieDetailViewModel
    let movieId: Int

    var body: some View {

        ScrollView {
            VStack(alignment: .leading) {
                MovieDetailHeaderView()

                Text("Overview")
                    .bold()
                    .padding(10)
                    .font(.title3)
                    .foregroundColor(.white)

                Text(viewModel.overview)
                    .padding(.horizontal, 10)
                    .foregroundColor(.white)
                    .font(.body)

                if !viewModel.videos.isEmpty {
                    VideosListView()
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
    }
}

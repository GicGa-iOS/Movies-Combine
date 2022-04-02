import SwiftUI

struct MovieDetailHeaderView: View {

    @EnvironmentObject var viewModel: MovieDetailViewModel

    var body: some View {

        ZStack(alignment: .topLeading) {
            if let url = viewModel.backdropURL {
                ImageLoader.makeImage(url: url)
                    .frame(maxWidth: .infinity, maxHeight: 220)
            }
            HStack {
                if let url = viewModel.posterURL {
                    PosterView(url: url, network: nil)
                }
                VStack(alignment: .leading) {
                    Text(viewModel.movieTitle)
                        .foregroundColor(.white)
                        .bold()
                        .font(.title2)
                    Text(viewModel.voteAverage)
                        .foregroundColor(.purple)
                    Text(viewModel.runTime)
                        .foregroundColor(.white)
                    Text(viewModel.budget)
                        .foregroundColor(.white)
                    Text(viewModel.revenue)
                        .foregroundColor(.white)
                }
                .padding(.leading, 10)
            }
            .padding(.top, viewModel.backdropURL != nil ? 170 : 0)
        }
    }
}

struct MovieDetailHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailHeaderView()
            .environmentObject(MovieDetailViewModel(service: MovieDetailService(networkRequest: NativeRequestable())))
    }
}

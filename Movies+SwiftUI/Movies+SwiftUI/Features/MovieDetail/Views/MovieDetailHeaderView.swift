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
                    ImageLoader.makeImage(url: url)
                        .frame(width: 150, height: 230)
                        .shadow(color: .gray, radius: 5)
                }
                VStack(alignment: .leading) {
                    Text(viewModel.movieTitle)
                        .foregroundColor(.white)
                        .bold()
                        .font(.title2)
                    Text(viewModel.voteAverage)
                        .foregroundColor(.purple)
                    Text(viewModel.popularity)
                        .foregroundColor(.white)
                    Text(viewModel.revenue)
                        .foregroundColor(.white)
                }
                .padding(.leading, 10)
            }
            .padding(.top, 170)
        }
    }
}

struct MovieDetailHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailHeaderView()
            .environmentObject(MovieDetailViewModel())
    }
}

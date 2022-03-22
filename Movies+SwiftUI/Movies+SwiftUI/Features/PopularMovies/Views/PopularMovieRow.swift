import SwiftUI

struct PopularMovieRow: View {

    let movie: Result
    @State var progressValue: Float = 0.0
    @State private var isActive = false

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let url = URL(string: APIConstants.imgBaseURL+(movie.posterPath ?? "")) {
                ImageLoader.makeImage(url: url)
            }
            ProgressBar(progress: $progressValue)
                .frame(width: 50.0, height: 50.0)
                .padding(10.0)
                .opacity(0.8)
        }
        .onTapGesture {
            self.isActive = true
        }
        .onAppear(perform: {
            progressValue = Float(movie.voteAverage ?? 0)/10
        })
        .frame(maxWidth: .infinity, alignment: .center)
        .background(
            NavigationLink (
                destination: MovieDetailScreen(movie: movie), isActive: $isActive,
                label: {
                    EmptyView()
                }
            ))
    }
}

struct PopularMovieRow_Previews: PreviewProvider {
    static var previews: some View {
        PopularMovieRow(movie: Helper.makeResult())

    }
}

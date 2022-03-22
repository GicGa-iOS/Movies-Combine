import SwiftUI
import NukeUI

struct PopularMovieRow: View {
    let movie: Result
    @State var progressValue: Float = 0.0

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let url = URL(string: APIConstants.imgBaseURL+(movie.posterPath ?? "")) {
                makeImage(url: url)
            }
            ProgressBar(progress: $progressValue)
                .frame(width: 50.0, height: 50.0)
                .padding(10.0)
                .opacity(0.8)
        }.onAppear(perform: {
            progressValue = Float(movie.voteAverage ?? 0)/10
        })
        .frame(maxWidth: .infinity, alignment: .center)
    }

    // This is where the image view is created.
    func makeImage(url: URL) -> some View {
        LazyImage(source: url, resizingMode: .aspectFit)
    }
}

struct PopularMovieRow_Previews: PreviewProvider {
    static var previews: some View {
        PopularMovieRow(movie: Helper.makeResult())

    }
}

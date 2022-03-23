import SwiftUI

struct VideosListView: View {

    @EnvironmentObject var viewModel: MovieDetailViewModel
    
    var rows: [GridItem] = Array(repeating: .init(.fixed(200)), count: 1)

    var body: some View {

        VStack(alignment:.leading) {
            Text("Media")
                .foregroundColor(.white)
                .font(.title)
                .padding(.leading)

            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, alignment: .center) {
                    ForEach(viewModel.videos, id: \.id) { video in
                        VStack {
                            if let url = getURL(urlstring: video.key) {
                                LinkView(link: url)
                                    .frame(width: 300)
                            }

                            Text(video.name ?? "")
                                .foregroundColor(.white)
                                .font(.callout)
                        }
                    }
                }
            }.frame(height: 200)
        }.frame( maxWidth: .infinity)
    }

    func getURL(urlstring: String?) -> URL? {
        if let string = urlstring, let url = URL(string: APIConstants.youtubeEmbed+string) {
            return url
        }
        return nil
    }
}

struct ActorsListView_Previews: PreviewProvider {
    static var previews: some View {
        VideosListView()
            .environmentObject(MovieDetailViewModel())
    }
}

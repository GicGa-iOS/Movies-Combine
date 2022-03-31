import SwiftUI

struct VideosListView: View {

    var rows: [GridItem] = Array(repeating: .init(.fixed(200)), count: 1)
    let videos: [DetailResultModel]

    var body: some View {

        VStack(alignment:.leading) {
            Text("Media")
                .foregroundColor(.white)
                .font(.title)
                .padding(.leading)

            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, alignment: .center) {
                    ForEach(videos, id: \.id) { video in
                        VStack {
                            if let url = getURL(urlstring: video.key) {
                                LinkView(link: url)
                                    .frame(width: 300, height: 160)
                            }

                            Text(video.name ?? "")
                                .fixedSize(horizontal: false, vertical: true)
                                .frame(width: 300, height: 80)
                                .foregroundColor(.white)
                                .font(.callout)
                        }
                    }
                }
            }.frame(maxHeight: 300)
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
        VideosListView(videos: [DetailResultModel(iso639_1: nil,
                                                    iso3166_1: nil,
                                                    name: "The Last Kingdom | Series 1 Full TrailerThe Last Kingdom | Series 1 Full Trailer",
                                                    key: "WxPApTGWwas",
                                                    publishedAt: nil,
                                                    site: "YouTube",
                                                    size: nil,
                                                    type: "Trailer",
                                                    official: nil,
                                                    id: nil)])
    }
}

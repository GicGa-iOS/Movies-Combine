import SwiftUI

struct MultilistScreen: View {

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                MultiListHeaderView()

                HorizontalPortraitSectionView(title: "Trending movies")
                HorizontalPortraitSectionView(title: "Trending tv")
                HorizontalPortraitSectionView(title: "Popular")
                HorizontalPortraitSectionView(title: "Upcoming movies")
                HorizontalPortraitSectionView(title: "Top rated")
            }
        }.background(.black)
    }
}

struct MultilistScreen_Previews: PreviewProvider {
    static var previews: some View {
        MultilistScreen()
    }
}

struct HorizontalPortraitSectionView: View {

    let title: String

    let rows = [
        GridItem(.flexible())
    ]

    let images = ["https://image.tmdb.org/t/p/w500/bBRlrpJm9XkNSg0YT5LCaxqoFMX.jpg",
                  "https://image.tmdb.org/t/p/w500/xKUuGr8aHQRl8OfhBwhnDlcwr2L.jpg",
                  "https://image.tmdb.org/t/p/w500/ip7aXVH8s6wXv8cY6KI14OZgCI8.jpg",
                  "https://image.tmdb.org/t/p/w500/l6zPRmg8NI7Y65G5GUqwvjxFdsx.jpg"]

    var body: some View {
        Text(title)
            .foregroundColor(.white)
            .font(.headline)
            .padding(.top, 10)
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows:rows) {
                ForEach(images, id: \.self) { image in

                    if let url = URL(string: image) {
                        ImageLoader.makeImage(url: url)
                            .frame(width: 140, height: 200)
                    }
                }
            }
        }.frame(height: 200)
    }
}

struct MultiListHeaderView: View {

    var body: some View {
        ZStack(alignment: .bottom) {
            ImageLoader.makeImage(url: URL(string: "https://image.tmdb.org/t/p/w500/bBRlrpJm9XkNSg0YT5LCaxqoFMX.jpg")!)

            Rectangle()
                .foregroundColor(.clear)
                .background(
                    LinearGradient(gradient: Gradient(colors: [.clear, .black]), startPoint: .top, endPoint: .bottom)
                )
            Text("Titulo de película")
                .font(.title)
                .foregroundColor(.white)
                .padding(.bottom, 30)
        }
        .frame(height: 590)
        .frame(maxWidth: .infinity)
    }
}

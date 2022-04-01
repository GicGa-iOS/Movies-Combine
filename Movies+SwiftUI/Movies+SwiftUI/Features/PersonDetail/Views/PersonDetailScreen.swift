import SwiftUI

struct PersonDetailScreen: View {

    let names = ["Thomas Stanley Holland", "Том Холланд",
                 "トム・ホランド", "톰 홀랜드", "توم هولاند", "ทอม ฮอลแลนด์", "汤姆·赫兰德",
                 "Τομ Χόλαντ", "Том Голланд", "תומאס סטנלי הולנד"]

    let rows = [
        GridItem(.flexible())
    ]

    let images = ["https://image.tmdb.org/t/p/w500/bBRlrpJm9XkNSg0YT5LCaxqoFMX.jpg",
                  "https://image.tmdb.org/t/p/w500/xKUuGr8aHQRl8OfhBwhnDlcwr2L.jpg",
                  "https://image.tmdb.org/t/p/w500/ip7aXVH8s6wXv8cY6KI14OZgCI8.jpg",
                  "https://image.tmdb.org/t/p/w500/l6zPRmg8NI7Y65G5GUqwvjxFdsx.jpg"]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                PersonDetailHeaderView()

                Text("Also know as")
                    .bold()
                    .foregroundColor(.white)

                ReadjustingStackView(data: names, spacing: 8, alignment: .leading) { item in
                    Text(item)
                        .foregroundColor(.white)
                        .padding(5)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.gray.opacity(0.2))
                        )

                }

                ScrollView(.horizontal) {
                    LazyHGrid(rows:rows) {
                        ForEach(images, id: \.self) { image in

                            if let url = URL(string: image)! {
                                ImageLoader.makeImage(url: url)
                                    .frame(width: 160, height: 250)
                            }
                        }
                    }
                }.frame(height: 400)
            }
            .frame(maxWidth: .infinity)
        }
        .background(Color.black)
    }
}

struct PersonDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailScreen()
    }
}

struct PersonDetailHeaderView: View {
    var body: some View {
        HStack(alignment: .center) {
            ImageLoader.makeImage(url: URL(string: "https://image.tmdb.org/t/p/w500/bBRlrpJm9XkNSg0YT5LCaxqoFMX.jpg")!)
                .frame(width:160, height: 250)

            VStack(alignment: .leading) {
                Text("Know For")
                    .foregroundColor(.white)
                    .bold()
                Text("Acting")
                    .foregroundColor(.white)
                Text("Gender")
                    .bold()
                    .foregroundColor(.white)
                Text("Male")
                    .foregroundColor(.white)
                Text("Birthday")
                    .bold()
                    .foregroundColor(.white)
                Text("2019")
                    .foregroundColor(.white)
                Text("Place of Birth")
                    .bold()
                    .foregroundColor(.white)
                Text("England")
                    .foregroundColor(.white)
            }
            Spacer()
        }
    }
}

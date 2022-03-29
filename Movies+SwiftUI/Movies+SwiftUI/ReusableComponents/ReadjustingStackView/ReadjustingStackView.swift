import SwiftUI

struct ReadjustingStackView<Data: RandomAccessCollection, Content: View>: View where Data.Element: Hashable {
    let data: Data
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: (Data.Element) -> Content
    @State private var availableWidth: CGFloat = 0

    var body: some View {
        ZStack {
            Color.clear
                .frame(height: 1)
                .readSize { size in
                    availableWidth = size.width
                }

            _FlexibleView(availableWidth: availableWidth,
                          data: data,
                          spacing: spacing,
                          alignment: alignment,
                          content: content)
            .frame(maxWidth: .infinity)
        }
    }
}

struct ReadjustingStackView_Previews: PreviewProvider {
    static var previews: some View {
        let data = [GenreModel(id: 28, name: "Action"),
                    GenreModel(id: 12, name: "Adventure"),
                    GenreModel(id: 35, name: "Comedy"),
                    GenreModel(id: 878, name: "Science Fiction"),
                    GenreModel(id: 18, name: "Drama")]
        ReadjustingStackView(data: data, spacing: 8, alignment: .leading) { item in
            Text(item.name)
        }
    }
}

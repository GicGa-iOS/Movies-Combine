import SwiftUI

struct SearchDetailView: View {

    let searchItem: MultiSearchResultModel

    var body: some View {
        getDetailForMediaType(item: searchItem)
    }

    // MARK: - Private Functions

    private func getDetailForMediaType(item: MultiSearchResultModel) -> some View {
        guard
            let itemId = item.id,
            let media = item.mediaType
        else {
            return AnyView(Text(item.title ?? ""))
        }

        switch media {
        case .movie:
            return AnyView(MovieDetailScreen(movieId: itemId))

        case .person:
            return AnyView(Text("person"+(item.title ?? "")))

        case .tv:
            return AnyView(TVDetailScreen(tvId: itemId))
        }
    }
    
}

struct SearchDetailView_Previews: PreviewProvider {
    static var previews: some View {
        SearchDetailView(searchItem: Helper.makeMultiSearchResultModel())
    }
}

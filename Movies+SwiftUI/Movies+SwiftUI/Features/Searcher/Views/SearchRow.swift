import SwiftUI

struct SearchRow: View {

    @EnvironmentObject var viewModel: SearchViewModel

    let searchItem: MultiSearchResultModel

    var body: some View {
        if let stng = viewModel.getPath(item: searchItem), let url = URL(string: APIConstants.posterBaseURL+stng) {
            ZStack(alignment: .topLeading) {
                ImageLoader.makeImage(url: url)
                    .frame(minWidth: 100, minHeight: 200)
                Text(viewModel.getMediaType(item: searchItem))
                    .foregroundColor(.white)
                    .background(Color.black)
                    .opacity(0.6)
                    .padding(5)
                    .cornerRadius(5)
            }
        } else {
            VStack {
                Text((searchItem.posterPath ?? viewModel.getTitle(item: searchItem)) ?? "No title available")
                Text(viewModel.getMediaType(item: searchItem))
                    .font(.footnote)
            }
        }
    }
}

struct SearchRow_Previews: PreviewProvider {
    static var previews: some View {
        SearchRow(searchItem: Helper.makeMultiSearchResultModel())
            .environmentObject(SearchViewModel(service: MultiSearchService(networkRequest: NativeRequestable())))
    }
}

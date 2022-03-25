import SwiftUI

struct SearcherScreen: View {

    var rows: [GridItem] = Array(repeating: .init(.flexible()), count: 3)

    @EnvironmentObject var viewModel: SearchViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: rows) {
                    ForEach(viewModel.repos, id: \.id) { item in
                        NavigationLink(destination: Text(item.title ?? "")) {

                            if let stng = viewModel.getPath(item: item), let url = URL(string: APIConstants.posterBaseURL+stng) {
                                ZStack(alignment: .topLeading) {
                                    ImageLoader.makeImage(url: url)
                                        .frame(minWidth: 100, minHeight: 200)
                                    Text(viewModel.getMediaType(item: item))
                                        .foregroundColor(.white)
                                        .background(Color.black)
                                        .opacity(0.6)
                                        .padding(5)
                                        .cornerRadius(5)
                                }
                            } else {
                                VStack {
                                    Text((item.posterPath ?? viewModel.getTitle(item: item)) ?? "No title available")
                                    Text(viewModel.getMediaType(item: item))
                                        .font(.footnote)
                                }
                            }
                        }
                    }
                    if viewModel.canLoadNextPage {
                        Spinner(style: .medium)
                            .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
                            .onAppear {
                                viewModel.searchNextPageIfPossible()
                            }
                    }
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.black)
        }.searchable(text: $viewModel.searchQuery,
                     placement: .navigationBarDrawer(displayMode: .always),
                     prompt: "Search"
        )
    }
}

struct SearcherScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearcherScreen()
            .environmentObject(SearchViewModel(service: MultiSearchService(networkRequest: NativeRequestable())))
    }
}

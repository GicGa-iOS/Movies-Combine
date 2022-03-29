import SwiftUI

struct SearcherScreen: View {

    var rows: [GridItem] = Array(repeating: .init(.flexible()), count: 3)

    @EnvironmentObject var viewModel: SearchViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: rows) {
                    ForEach(viewModel.repos, id: \.id) { item in

                        NavigationLink {
                            SearchDetailView(searchItem: item)
                        } label: {
                            SearchRow(searchItem: item)
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

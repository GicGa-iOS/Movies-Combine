import SwiftUI

struct SearcherScreen: View {

    let names = ["Holly", "Josh", "Rhonda", "Ted"]
    var rows: [GridItem] = Array(repeating: .init(.flexible()), count: 3)

    @State private var searchText = ""

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: rows) {
                    ForEach(searchResults, id: \.self) { name in
                        NavigationLink(destination: Text(name)) {
                            Text(name)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.black)
        }.searchable(text: $searchText,
                     placement: .navigationBarDrawer(displayMode: .always),
                     prompt: "Search"
        ) {
            ForEach(searchResults, id: \.self) { result in
                Text("Are you looking for \(result)?")
                    .searchCompletion(result)
            }
        }
    }

    var searchResults: [String] {
        if searchText.isEmpty {
            return names
        } else {
            return names.filter { $0.contains(searchText) }
        }
    }
}

struct SearcherScreen_Previews: PreviewProvider {
    static var previews: some View {
        SearcherScreen()
    }
}

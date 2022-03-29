import SwiftUI

struct GenresView: View {

    @EnvironmentObject var viewModel: MovieGenresViewModel

    let useSpecificGenres: [MovieGenre]?
    @State var enableGenreTapGesture: Bool
    let alignment: HorizontalAlignment

    var body: some View {
        ReadjustingStackView(data: useSpecificGenres ?? viewModel.repos,
                             spacing: viewModel.spacing,
                             alignment: alignment) { item in

            getStackContent(enableTap: enableGenreTapGesture, item: item)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.2))
                )
        }.onAppear {
            if useSpecificGenres?.isEmpty ?? true {
                viewModel.getMovieGenres()
            }
        }
    }

    private func getStackContent(enableTap: Bool, item: MovieGenre) -> some View {
        if enableGenreTapGesture {
            return AnyView(Button(action: {}) {
                HStack {
                    Text(item.name)
                        .foregroundColor(.white)
                }
            })
        } else {
            return AnyView(Text(item.name).foregroundColor(.white))
        }
    }
}

struct GenresView_Previews: PreviewProvider {
    static var previews: some View {
        GenresView(useSpecificGenres: nil, enableGenreTapGesture: true, alignment: .leading)
            .environmentObject(
                MovieGenresViewModel(
                    service: MovieGenreService(
                        networkRequest: NativeRequestable()
                    )
                )
            )
    }
}


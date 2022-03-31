import SwiftUI

struct TVDetailScreen: View {

    @EnvironmentObject var viewModel: TVDetailViewModel

    let tvId: Int

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                TVDetailHeaderView()

                Text(viewModel.tvDetail.tagline ?? "")
                    .bold()
                    .font(.headline.italic())
                    .padding(.leading, 10)
                    .foregroundColor(Color(UIColor.lightGray))

                GenresView(useSpecificGenres: viewModel.tvDetail.genres, enableGenreTapGesture: false, alignment: .center)

                Text("Overview")
                    .bold()
                    .padding(10)
                    .font(.title3)
                    .foregroundColor(.white)

                ExpandableText(viewModel.tvDetail.overview ?? "", lineLimit: 3)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 20, trailing: 10))
                    .foregroundColor(.white)
                    .font(.body)

                if !(viewModel.tvDetail.videos?.results ?? []).isEmpty {
                    VideosListView(videos: viewModel.tvDetail.videos?.results ?? [])
                        .padding(.top, 10)
                }
            }
        }
        .background(Color.black)
        .navigationBarTitle("TV")
        .onAppear {
            viewModel.tvId = tvId
        }
    }
}

struct TVDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        TVDetailScreen(tvId: 63333)
            .environmentObject(TVDetailViewModel(service: FetchTVDetailService(networkRequest: NativeRequestable())))
            .environmentObject(
                GenreModelsViewModel(
                    service: GenreModelService(
                        networkRequest: NativeRequestable()
                    )
                )
            )
    }
}

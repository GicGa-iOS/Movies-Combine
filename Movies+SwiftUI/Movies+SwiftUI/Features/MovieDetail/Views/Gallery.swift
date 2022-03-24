import SwiftUI

struct Gallery: View {

    @EnvironmentObject var viewModel: MovieDetailViewModel

    let rows = [
        GridItem(.flexible())
    ]

    var body: some View{
        VStack(alignment:.leading) {

            Text("Gallery")
                .foregroundColor(.white)
                .font(.title)
                .padding(.leading)

                ScrollView(.horizontal) {
                    LazyHGrid(rows:rows) {
                        ForEach(viewModel.images, id: \.self) { image in

                            if let url = URL(string: APIConstants.backdropBaseURL.normalSize+(image.filePath ?? "")!) {
                                ImageLoader.makeImage(url: url)
                                    .frame(width: 300, height: 200)
                            }
                        }
                    }
                }.frame(height: 200)
        }.frame(maxWidth: .infinity)
    }
}

struct Gallery_Previews: PreviewProvider {
    static var previews: some View {
        Gallery()
            .environmentObject(MovieDetailViewModel(service: MovieDetailService(networkRequest: NativeRequestable())))
    }
}

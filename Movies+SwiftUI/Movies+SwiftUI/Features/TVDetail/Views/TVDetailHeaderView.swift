import SwiftUI

struct TVDetailHeaderView: View {

    @EnvironmentObject var viewModel: TVDetailViewModel

    var body: some View {
        ZStack(alignment: .topLeading) {
            if let urlstring = viewModel.tvDetail.backdropPath,
               let url = URL(string: APIConstants.backdropBaseURL.normalSize+urlstring) {
                ImageLoader.makeImage(url: url)
                    .frame(maxWidth: .infinity, maxHeight: 220)
            }
            HStack {
                if let urlstring = APIConstants.posterBaseURL+(viewModel.tvDetail.posterPath ?? ""),
                   let url = URL(string: urlstring) {
                    ExtractedView(url: url, network: viewModel.tvDetail.networks?.first)
                }
                VStack(alignment: .leading) {
                    Text(viewModel.tvDetail.name ?? "")
                        .foregroundColor(.white)
                        .bold()
                        .font(.title2)
                    Text(viewModel.tvDetail.firstAirDate ?? "")
                        .foregroundColor(.gray)
                        .bold()
                        .font(.title2)
                    Text("\(viewModel.tvDetail.voteAverage ?? 0)")
                        .foregroundColor(.purple)
                    Text("\(viewModel.tvDetail.popularity ?? 0)")
                        .foregroundColor(.white)
                    Text(viewModel.tvDetail.status ?? "")
                        .foregroundColor(.white)
                }
                .padding(.leading, 10)
            }
            .padding(.top, viewModel.tvDetail.backdropPath != nil ? 170 : 0)
        }
    }
}

struct TVDetailHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        TVDetailHeaderView()
            .environmentObject(TVDetailViewModel(service: FetchTVDetailService(networkRequest: NativeRequestable())))
    }
}

struct ExtractedView: View {
    let url: URL
    let network: NetworkModel?

    var body: some View {

        VStack {
            ImageLoader.makeImage(url: url)
                .frame(width: 150, height: 230)
                .shadow(color: .gray, radius: 5)
            if let net = network {
                HStack(alignment: .center) {
                    if let urlstring = APIConstants.posterBaseURL+(net.logoPath ?? ""),
                       let url = URL(string: urlstring) {
                        ImageLoader.makeImage(url: url)
                            .frame(width: 30, height: 30)
                            .shadow(color: .gray, radius: 5)
                    }
                    VStack {
                        Text("Now streaming")
                            .font(.callout)
                            .foregroundColor(.gray)
                        Text("Watch Now")
                            .font(.callout)
                            .foregroundColor(.white)
                    }
                }
                .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                .background(Color.indigo)
            }
        }
    }
}

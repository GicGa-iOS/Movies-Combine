import Combine
import Foundation

class MovieDetailViewModel: ObservableObject {

    typealias DetailAlias = Result<MovieDetail, Error>

    // MARK: Input

    @Published var movieId: Int = 0

    // MARK: Output

    @Published var movieTitle: String = ""
    @Published var backdropURL: URL?
    @Published var posterURL: URL?
    @Published var popularity: String = ""
    @Published var revenue: String = ""
    @Published var voteAverage: String = ""
    @Published var overview: String = ""
    @Published var videos : [MovieDetailResult] = []
    @Published var images: [MovieBackdrop] = []

    private lazy var fetchDetailPublisher: AnyPublisher<DetailAlias, Never> = {
        $movieId
            .flatMap { detailId -> AnyPublisher<DetailAlias, Never> in
                FetchMovieDetailService.fetchDetail(id: detailId)
                    .asResult()
            }
            .receive(on: DispatchQueue.main)
            .share()
            .eraseToAnyPublisher()
    }()

    init() {

        fetchDetailPublisher
            .map { result in
                switch result{
                case .success(let data):
                    return data.images?.backdrops ?? []
                case .failure(_):
                    return []
                }
            }
            .assign(to: &$images)

        fetchDetailPublisher
            .map { result in
                switch result{
                case .success(let data):
                    return data.videos?.results ?? []
                case .failure(_):
                    return []
                }
            }
            .assign(to: &$videos)

        fetchDetailPublisher
            .map({ result in
                switch result{
                case .success(let data):
                    return data.overview ?? ""
                case .failure(_):
                    return ""
                }
            })
            .assign(to: &$overview)

        fetchDetailPublisher
            .map({ result in
                switch result{
                case .success(let data):
                    return "\(data.voteAverage ?? 0)"
                case .failure(_):
                    return ""
                }
            })
            .assign(to: &$voteAverage)

        fetchDetailPublisher
            .map({ result in
                switch result{
                case .success(let data):
                    return "Popularity: \(data.popularity ?? 0)"
                case .failure(_):
                    return "Popularity: -"
                }
            })
            .assign(to: &$popularity)

        fetchDetailPublisher
            .map({ result in
                switch result{
                case .success(let data):
                    return "Revenue: \(data.revenue ?? 0)"
                case .failure(_):
                    return "evenue: -"
                }
            })
            .assign(to: &$revenue)

        fetchDetailPublisher
            .map { result in
                switch result {
                case .success(let detail):
                    return detail.title ?? ""

                case .failure(_):
                    return ""
                }
            }
            .assign(to: &$movieTitle)

        fetchDetailPublisher
            .map { result in

                switch result {
                case .success(let detail):
                    if let urlString = detail.backdropPath,
                       let url = URL(string: APIConstants.backdropBaseURL.normalSize+urlString) {
                        return url
                    }
                    return URL(string: "")

                case .failure(_):
                    return URL(string: "")
                }
            }.assign(to: &$backdropURL)

        fetchDetailPublisher
            .map { result in

                switch result {
                case .success(let detail):
                    if let urlString = detail.posterPath,
                       let url = URL(string: APIConstants.posterBaseURL+urlString) {
                        return url
                    }
                    return URL(string: "")

                case .failure(_):
                    return URL(string: "")
                }
            }.assign(to: &$posterURL)
    }
}
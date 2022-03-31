import Combine
import Foundation

class TVDetailViewModel: ObservableObject {

    typealias TVAlias = Result<TVDetailModel, Error>

    // MARK: - Inputs

    @Published var tvId: Int = 0

    // MARK: - Outputs

    @Published var tvDetail: TVDetailModel = TVDetailModel(adult: nil, backdropPath: nil, createdBy: nil, episodeRunTime: nil, firstAirDate: nil, genres: nil, homepage: nil, id: 63333, inProduction: nil, languages: nil, lastAirDate: nil, lastEpisodeToAir: nil, name: nil, nextEpisodeToAir: nil, networks: nil, numberOfEpisodes: nil, numberOfSeasons: nil, originCountry: nil, originalLanguage: nil, originalName: nil, overview: nil, popularity: nil, posterPath: nil, productionCompanies: nil, productionCountries: nil, seasons: nil, spokenLanguages: nil, status: nil, tagline: nil, type: nil, voteAverage: nil, voteCount: nil, videos: nil, images: nil)

    // MARK: - Private Properties

    private let service: FetchTVDetailService
    private lazy var fetchTVDetail: AnyPublisher<TVAlias, Never> = {
        $tvId
            .flatMap { id in
                self.service.fetchDetail(id: id)
                    .asResult()
            }
            .receive(on: DispatchQueue.main)
            .share()
            .eraseToAnyPublisher()
    }()

    // MARK: - Initialization

    init(service: FetchTVDetailService) {
        self.service = service

        fetchTVDetail
            .map { result in
                switch result {
                case .success(let data):
                    return data
                case .failure(_):
                    return TVDetailModel(adult: nil, backdropPath: nil, createdBy: nil, episodeRunTime: nil, firstAirDate: nil, genres: nil, homepage: nil, id: nil, inProduction: nil, languages: nil, lastAirDate: nil, lastEpisodeToAir: nil, name: nil, nextEpisodeToAir: nil, networks: nil, numberOfEpisodes: nil, numberOfSeasons: nil, originCountry: nil, originalLanguage: nil, originalName: nil, overview: nil, popularity: nil, posterPath: nil, productionCompanies: nil, productionCountries: nil, seasons: nil, spokenLanguages: nil, status: nil, tagline: nil, type: nil, voteAverage: nil, voteCount: nil, videos: nil, images: nil)
                }
            }
            .assign(to: &$tvDetail)
    }
}

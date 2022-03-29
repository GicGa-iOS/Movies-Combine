import Combine
import Foundation

protocol PopularMoviesInterface {
    var networkRequest: Requestable { get }

    func fetchPopularMovies(page: String) -> AnyPublisher<PopularMovieModel, Error>
}

class PopularMoviesService: PopularMoviesInterface {

    // MARK: - Internal Properties

    internal var networkRequest: Requestable

    // MARK: - Initialization

    init(networkRequest: Requestable) {
        self.networkRequest = networkRequest
    }

    func fetchPopularMovies(page: String) -> AnyPublisher<PopularMovieModel, Error> {
        let endpoint = PopularServiceEndpoints.fetchPopular(page: page)
        let request = endpoint.createRequest()
        return self.networkRequest.request(request)
    }
}

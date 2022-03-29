import Combine
import Foundation

protocol MovieGenreInterface {
    var networkRequest: Requestable { get }

    func getGenres() -> AnyPublisher<MoviesGenreList, Error>
}

class MovieGenreService: MovieGenreInterface {

    // MARK: - Internal Properties

    var networkRequest: Requestable

    // MARK: - Initialization

    init(networkRequest: Requestable) {
        self.networkRequest = networkRequest
    }

    func getGenres() -> AnyPublisher<MoviesGenreList, Error> {
        let endpoint = MovieGenreEndpoints.getGenres
        let request = endpoint.createRequest()
        return networkRequest.request(request)
    }
}

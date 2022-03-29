import Combine
import Foundation

protocol GenreModelInterface {
    var networkRequest: Requestable { get }

    func getGenres() -> AnyPublisher<MoviesGenreListModel, Error>
}

class GenreModelService: GenreModelInterface {

    // MARK: - Internal Properties

    var networkRequest: Requestable

    // MARK: - Initialization

    init(networkRequest: Requestable) {
        self.networkRequest = networkRequest
    }

    func getGenres() -> AnyPublisher<MoviesGenreListModel, Error> {
        let endpoint = GenreModelEndpoints.getGenres
        let request = endpoint.createRequest()
        return networkRequest.request(request)
    }
}

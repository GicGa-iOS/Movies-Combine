import Combine
import Foundation

protocol MovieDetailInterface {
    var networkRequest: Requestable { get }

    func fetchDetail(id: Int) -> AnyPublisher<MovieDetailModel, Error>
}

class MovieDetailService: MovieDetailInterface {

    // MARK: - Internal Properties

    internal var networkRequest: Requestable

    // MARK: - Initialization

    init(networkRequest: Requestable) {
        self.networkRequest = networkRequest
    }

    func fetchDetail(id: Int) -> AnyPublisher<MovieDetailModel, Error> {
        let endpoint = MovieDetailEndpoints.fetchDetail(id: id)
        let request = endpoint.createRequest()
        return self.networkRequest.request(request)
    }
}

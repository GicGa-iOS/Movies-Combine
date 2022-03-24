import Combine
import Foundation

protocol MultiSearchInterface {
    var networkRequest: Requestable { get }

    func search(query: String, page: Int) -> AnyPublisher<MultiSearchModel, Error>
}

class MultiSearchService: MultiSearchInterface {

    // MARK: - internal Properties

    internal var networkRequest: Requestable

    // MARK: - Initialization

    init(networkRequest: Requestable) {
        self.networkRequest = networkRequest
    }

    func search(query: String, page: Int) -> AnyPublisher<MultiSearchModel, Error> {
        let endpoint = MultiSearchEndpoints.search(query: query, page: page)
        let request = endpoint.createRequest()
        return self.networkRequest.request(request)
    }
}

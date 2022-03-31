import Combine
import Foundation

protocol TVDetailInterface {
    var networkRequest: Requestable { get }

    func fetchDetail(id: Int) -> AnyPublisher<TVDetailModel, Error>
}

class FetchTVDetailService: TVDetailInterface {

    // MARK: - Internal Properties

    internal var networkRequest: Requestable

    // MARK: - Initialization

    init(networkRequest: Requestable) {
        self.networkRequest = networkRequest
    }

    func fetchDetail(id: Int) -> AnyPublisher<TVDetailModel, Error> {
        let endpoint = TVDetailEndpoints.getTVDetail(id: id)
        let request = endpoint.createRequest()
        return self.networkRequest.request(request)
    }
}

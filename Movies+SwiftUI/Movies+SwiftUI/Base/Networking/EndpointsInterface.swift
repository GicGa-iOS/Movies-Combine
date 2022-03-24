import Foundation

protocol Endpoints {
    var requestTimeOut: Int { get }
    var httpMethod: HTTPMethod { get }
    var requestBody: Encodable? { get }

    func createRequest() -> NetworkRequest
    func getURL() -> String
}

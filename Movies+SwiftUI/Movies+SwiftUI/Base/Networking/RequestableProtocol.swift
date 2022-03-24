import Combine
import Foundation

public protocol Requestable {
    var requestTimeOut: Float { get }

    func request<T: Codable>(_ req: NetworkRequest) -> AnyPublisher<T, Error>
}

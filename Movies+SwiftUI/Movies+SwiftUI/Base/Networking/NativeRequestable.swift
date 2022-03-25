import Combine
import Foundation

public class NativeRequestable: Requestable {

    public var requestTimeOut: Float = 30

    public func request<T>(_ req: NetworkRequest) -> AnyPublisher<T, Error>
    where T: Decodable, T: Encodable {
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(req.requestTimeOut ?? requestTimeOut)

        guard
            let encodedURL = req.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
            let url = URL(string: encodedURL)
        else {
            // Return a fail publisher if the url is invalid
            return Fail(error: APIError.invalidRequestError("Invalid URL"))
                .eraseToAnyPublisher()
        }
        // We use the dataTaskPublisher from the URLSession which gives us a publisher to play around with.
        return URLSession.shared
            .dataTaskPublisher(for: req.buildURLRequest(with: url))
            .tryMap { output in
                print("Received response from server, now checking status code")
                // throw an error if response is nil
                guard let urlResponse = output.response as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }

                if (200..<300) ~= urlResponse.statusCode {
                }
                else {
                    let decoder = JSONDecoder()
                    let apiError = try decoder.decode(ErrorResponse.self, from: output.data)

                    if urlResponse.statusCode == 400 {
                        throw APIError.validationError(apiError.statusMessage)
                    }

                    if (500..<600) ~= urlResponse.statusCode {
                        let retryAfter = urlResponse.value(forHTTPHeaderField: "Retry-After")
                        throw APIError.serverError(statusCode: urlResponse.statusCode,
                                                   reason: apiError.statusMessage,
                                                   retryAfter: retryAfter)
                    }
                }
                return output.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                // return error if json decoding fails
                APIError.decodingError(error)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

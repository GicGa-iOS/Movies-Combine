import Combine
import Foundation

struct FetchPopularService {

    static func fetchPopularMovies(page: String) -> AnyPublisher<PopularMovie, Error> {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(Keys.Apiv3)&language=en-US&page=\(page)") else {
            return Fail(error: APIError.invalidRequestError("Invalid URL"))
                .eraseToAnyPublisher()
        }

        let dataTaskPublisher = URLSession.shared.dataTaskPublisher(for: url)
        // Handle URL errors (most likely not able to connect to the server)
            .mapError{ error -> Error in
                return APIError.transportError(error)
            }

        // Handle all other errors
            .tryMap{ (data, response) -> (data: Data, response: URLResponse) in
                print("Received response from server, now checking status code")

                guard let urlResponse = response as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }
                if (200..<300) ~= urlResponse.statusCode {
                }
                else {
                    let decoder = JSONDecoder()
                    let apiError = try decoder.decode(ErrorResponse.self, from: data)

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
                return (data, response)
            }

        return dataTaskPublisher
            .retry(2, withBackoff: 3) { error in
                if case APIError.serverError(_, _, _) = error {
                    return true
                }
                else {
                    return false
                }
            }
            .map(\.data)
            .tryMap { data -> PopularMovie in
                let decoder = JSONDecoder()
                do {
                    return try decoder.decode(PopularMovie.self, from: data)
                }
                catch {
                    throw APIError.decodingError(error)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

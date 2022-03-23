import Combine
import Foundation

struct FetchMovieDetailService {

    static func fetchDetail(id: Int) -> AnyPublisher<MovieDetail, Error> {
        guard
            let url = URL(string: "\(APIConstants.baseURL)/movie/\(id)?api_key=\(Keys.Apiv3)&language=en-US&append_to_response=videos,images&include_image_language=en,null")
        else {
            return Fail(error: APIError.invalidRequestError("Invalid URL"))
                .eraseToAnyPublisher()
        }

        let dataTaskPublisher = URLSession.shared.dataTaskPublisher(for: url)
            .mapError { error -> Error in
                return APIError.transportError(error)
            }

            .tryMap { (data, response) -> (data: Data, response: URLResponse) in
                print("Received response from server, now checking status code")

                guard
                    let urlResponse = response as? HTTPURLResponse
                else {
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
            .map(\.data)
            .tryMap { data -> MovieDetail in
                do {
                    return try JSONDecoder().decode(MovieDetail.self, from: data)
                }
                catch {
                    throw APIError.decodingError(error)
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

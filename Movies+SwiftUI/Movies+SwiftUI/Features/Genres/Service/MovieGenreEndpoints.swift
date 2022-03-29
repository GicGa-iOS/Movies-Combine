import Foundation

enum MovieGenreEndpoints: Endpoints {

    case getGenres

    var requestTimeOut: Int{
        return 30
    }

    var httpMethod: HTTPMethod {
        switch self {
        case .getGenres:
            return .GET
        }
    }

    var requestBody: Encodable? {
        switch self {
        default:
            return nil
        }
    }

    func createRequest() -> NetworkRequest {
        var headers: Headers = [:]
        headers["Content-Type"] = "application/json"
        return NetworkRequest(url: getURL(), headers: headers, reqBody: requestBody, httpMethod: httpMethod)

    }

    func getURL() -> String {
        let baseUrl = APIConstants.baseURL
        switch self {
        case .getGenres:
            return "\(baseUrl)/genre/movie/list?api_key=\(Keys.Apiv3)&language=\(APIConstants.language)"
        }
    }
}

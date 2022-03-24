import Foundation

public typealias Headers = [String: String]

enum PopularServiceEndpoints {

    // MARK: - Endpoints

    case fetchPopular(page: String)

    // MARK: - Time out

    var requestTimeOut: Int {
        return 20
    }

    // MARK: - HTTPMethod

    var httpMethod: HTTPMethod {
        switch self {
        case .fetchPopular:
            return .GET
        }
    }

    // MARK: - Encodable request body for POST
    
    var requestBody: Encodable? {
        switch self {
        default:
            return nil
        }
    }

    // MARK: - Compose the NetworkRequest

    func createRequest() -> NetworkRequest {
        var headers: Headers = [:]
        headers["Content-Type"] = "application/json"
        return NetworkRequest(url: getURL(), headers: headers, reqBody: requestBody, httpMethod: httpMethod)
    }

    // MARK: - Compose URLs for each request

    func getURL() -> String {
        let baseUrl = APIConstants.baseURL
        switch self {
        case .fetchPopular(let page):
            return "\(baseUrl)/movie/popular?api_key=\(Keys.Apiv3)&language=\(APIConstants.language)&page=\(page)"
        }
    }
}

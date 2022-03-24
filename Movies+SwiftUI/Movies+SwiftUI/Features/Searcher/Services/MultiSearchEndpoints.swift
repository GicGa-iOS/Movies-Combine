import Foundation

enum MultiSearchEndpoints: Endpoints {

    // MARK: - Endpoints

    case search(query: String, page: Int)

    // MARK: - Time out

    var requestTimeOut: Int{
        return 30
    }

    // MARK: - HTTPMethod

    var httpMethod: HTTPMethod {
        switch self {
        case .search(_, _):
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
        case .search(let query, let page):
            return "\(baseUrl)/search/multi?api_key=\(Keys.Apiv3)&language=\(APIConstants.language)&query=\(query)&page=\(page)&include_adult=true"
        }
    }
}

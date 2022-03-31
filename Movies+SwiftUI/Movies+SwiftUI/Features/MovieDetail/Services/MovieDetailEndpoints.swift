import Foundation

enum MovieDetailEndpoints {

    // MARK: - Endpoints

    case fetchDetail(id: Int)

    // MARK: - Time out

    var requestTimeOut: Int {
        return 20
    }

    // MARK: - HTTPMethod

    var httpMethod: HTTPMethod {
        switch self {
        case .fetchDetail:
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
        case .fetchDetail(let id):
            return "\(baseUrl)/movie/\(id)?api_key=\(Keys.Apiv3)&language=\(APIConstants.language)&append_to_response=videos,images&include_image_language=\(APIConstants.languageShort),null"
        }
    }
}

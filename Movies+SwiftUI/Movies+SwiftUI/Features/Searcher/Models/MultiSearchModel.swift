import Foundation

// MARK: - MultiSearchModel

struct MultiSearchModel: Codable {
    let page: Int?
    let results: [MultiSearchResultModel]?
    let totalPages, totalResults: Int?

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

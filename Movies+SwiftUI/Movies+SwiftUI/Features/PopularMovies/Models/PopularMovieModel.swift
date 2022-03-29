import Foundation

// MARK: - PopularMovieModel

struct PopularMovieModel: Codable {
    let page: Int
    let results: [PopularMovieResultModel]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

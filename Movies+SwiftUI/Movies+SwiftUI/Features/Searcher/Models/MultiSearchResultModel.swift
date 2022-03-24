import Foundation

// MARK: - MultiSearchResultModel

struct MultiSearchResultModel: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let mediaType: MediaTypeModel?
    let originalLanguage: String?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let firstAirDate, name: String?
    let originCountry: [String]?
    let originalName: String?
    let gender: Int?
    let knownFor: [KnownForModel]?
    let knownForDepartment, profilePath: String?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case mediaType = "media_type"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
        case name
        case originCountry = "origin_country"
        case originalName = "original_name"
        case gender
        case knownFor = "known_for"
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
    }
}

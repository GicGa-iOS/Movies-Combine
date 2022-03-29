import Foundation

// MARK: - TVDetailModel

struct TVDetailModel: Codable {
    let adult: Bool?
    let backdropPath: String?
    let createdBy: [CreatedByModel]?
    let episodeRunTime: [Int]?
    let firstAirDate: String?
    let genres: [GenreModel]?
    let homepage: String?
    let id: Int?
    let inProduction: Bool?
    let languages: [String]?
    let lastAirDate: String?
    let lastEpisodeToAir: LastEpisodeToAirModel?
    let name: String?
    let nextEpisodeToAir: String?
    let networks: [NetworkModel]?
    let numberOfEpisodes, numberOfSeasons: Int?
    let originCountry: [String]?
    let originalLanguage, originalName, overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [NetworkModel]?
    let productionCountries: [ProductionCountryModel]?
    let seasons: [SeasonModel]?
    let spokenLanguages: [SpokenLanguageModel]?
    let status, tagline, type: String?
    let voteAverage: Double?
    let voteCount: Int?
    let videos: DetailVideosModel?
    let images: DetailImagesModel?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case createdBy = "created_by"
        case episodeRunTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        case genres, homepage, id
        case inProduction = "in_production"
        case languages
        case lastAirDate = "last_air_date"
        case lastEpisodeToAir = "last_episode_to_air"
        case name
        case nextEpisodeToAir = "next_episode_to_air"
        case networks
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case seasons
        case spokenLanguages = "spoken_languages"
        case status, tagline, type
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case videos, images
    }
}

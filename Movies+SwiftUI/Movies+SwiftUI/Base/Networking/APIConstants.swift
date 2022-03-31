import Foundation

enum APIConstants {

    enum backdropBaseURL {
        static private let backdropSize = "w780"
        static private let smallBackdropSize = "w300"
        static let smallSize = imageBase+smallBackdropSize
        static let normalSize = imageBase+backdropSize
    }

    static private let posterSize = "w500"
    static let posterBaseURL = imageBase+posterSize
    static private let imageBase = "https://image.tmdb.org/t/p/"
    static let baseURL = "https://api.themoviedb.org/3"
    static let language = "es-MX"
    static let languageShort = "es"
    static let youtubeEmbed = "https://www.youtube.com/embed/"
    static let vimeoEmbed = "https://player.vimeo.com/video/"
}

import Foundation

extension Helper {

    static func makeResult(adult: Bool = false,
                           backdropPath: String = "foo.backdropPath",
                           genreIDS: [Int] = [0,1],
                           id: Int = 0,
                           originalLanguage: String = "en",
                           originalTitle: String = "foo.name",
                           overview: String = "foo.overview",
                           popularity: Double = 0.7,
                           posterPath: String = "/wFjboE0aFZNbVOF05fzrka9Fqyx.jpg",
                           releaseDate: String = "2013-03-23",
                           title: String = "foo.title",
                           video: Bool = true,
                           voteAverage: Double = 0.5,
                           voteCount: Int = 100) -> Result {
        Result(adult: adult,
               backdropPath: backdropPath,
               genreIDS: genreIDS,
               id: id,
               originalLanguage: originalLanguage,
               originalTitle: originalTitle,
               overview: overview,
               popularity: popularity,
               posterPath: posterPath,
               releaseDate: releaseDate,
               title: title,
               video: video,
               voteAverage: voteAverage,
               voteCount: voteCount)
    }
}

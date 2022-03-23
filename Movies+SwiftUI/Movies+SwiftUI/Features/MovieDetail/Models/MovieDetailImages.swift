import Foundation

// MARK: - MovieDetailImages

struct MovieDetailImages: Codable {
    let backdrops, logos, posters: [MovieBackdrop]?
}

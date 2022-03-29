import Foundation

// MARK: - NetworkModel

struct NetworkModel: Codable {
    let name: String?
    let id: Int?
    let logoPath, originCountry: String?

    enum CodingKeys: String, CodingKey {
        case name, id
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
}

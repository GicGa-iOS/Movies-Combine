import Combine
import SwiftUI

class MovieGenresViewModel: ObservableObject {

    // MARK: - Outputs

    @Published var repos: [MovieGenre] = []
    @Published var spacing: CGFloat = 8

    // MARK: - Private Porperties

    private var subscriptions = Set<AnyCancellable>()
    private let service: MovieGenreService

    // MARK: - Initialization

    init(service: MovieGenreService) {
        self.service = service
    }

    // MARK: - Public Functions

    func getMovieGenres() {
        service.getGenres()
            .sink(receiveCompletion: onReceive,
                  receiveValue: onReceive)
            .store(in: &subscriptions)
    }

    // MARK: - Private functions

    private func onReceive(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure:
            break
        }
    }

    private func onReceive(_ batch: MoviesGenreList) {
        repos = batch.genres
    }
}

import Combine
import SwiftUI

class GenreModelsViewModel: ObservableObject {

    // MARK: - Outputs

    @Published var repos: [GenreModel] = []
    @Published var spacing: CGFloat = 8

    // MARK: - Private Porperties

    private var subscriptions = Set<AnyCancellable>()
    private let service: GenreModelService

    // MARK: - Initialization

    init(service: GenreModelService) {
        self.service = service
    }

    // MARK: - Public Functions

    func getGenreModels() {
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

    private func onReceive(_ batch: MoviesGenreListModel) {
        repos = batch.genres
    }
}

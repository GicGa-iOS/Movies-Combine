import Combine
import Foundation

class PopularMoviesViewModel: ObservableObject {

    @Published private(set) var state = State()
    struct State {
        var repos: [PopularMovieResult] = []
        var page: Int = 1
        var canLoadNextPage = true
    }

    // MARK: - Private Properties

    private var subscriptions = Set<AnyCancellable>()
    private let service: PopularMoviesService

    // MARK: - Initialization

    init(service: PopularMoviesService) {
        self.service = service
    }

    // MARK: - Internal functions

    func fetchMoviesNextPageIfPossible() {
        guard
            state.canLoadNextPage
        else { return }
        service.fetchPopularMovies(page: "\(state.page)")
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
            state.canLoadNextPage = false
        }
    }

    private func onReceive(_ batch: PopularMovie) {
        state.repos += batch.results
        state.page += 1
        state.canLoadNextPage = batch.totalPages >= state.page
    }
}

import Combine
import Foundation

class PopularMoviesViewModel: ObservableObject {

    @Published private(set) var state = State()
    private var subscriptions = Set<AnyCancellable>()
    // 2

    func fetchMoviesNextPageIfPossible() {
        guard state.canLoadNextPage else { return }
        FetchPopularService.fetchPopularMovies(page: "\(state.page)")
            .sink(receiveCompletion: onReceive,
                  receiveValue: onReceive)
            .store(in: &subscriptions)
    }

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

    struct State {
        var repos: [Result] = []
        var page: Int = 1
        var canLoadNextPage = true
    }
}

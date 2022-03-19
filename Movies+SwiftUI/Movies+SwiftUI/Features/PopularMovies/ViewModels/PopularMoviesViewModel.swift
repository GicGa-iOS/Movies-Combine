import Combine
import Foundation

class PopularMoviesViewModel: ObservableObject {

    @Published var movies = [Result]()

    // 2
    private var service = FetchPopularService()
    private var page = 1
    private var currentLastId: Int? = nil
    private var cancellable: AnyCancellable?

    func fetchMovies() {
        cancellable = service.fetchPopularMovies(page: "\(page)")
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("fetch popular moview finished")
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { movies in
                self.movies.append(contentsOf: movies)
            })
    }
}

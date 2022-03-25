import Combine
import Foundation

class SearchViewModel: ObservableObject {

    typealias Search = Result<MultiSearchModel, Error>

    // MARK: - Inputs

    @Published var searchQuery = ""

    // MARK: - Outputs

    @Published var repos: [MultiSearchResultModel] = []
    @Published var canLoadNextPage = true

    // MARK: - Private Properties

    @Published private var page: Int = 1
    @Published private var previousSearchDone: String = ""
    private var subscriptions = Set<AnyCancellable>()
    private let service: MultiSearchService
    private lazy var searchPublisher: AnyPublisher<Search, Never> = {
        $searchQuery
            .debounce(for: 0.8, scheduler: DispatchQueue.main)
            .removeDuplicates()
            .flatMap { query -> AnyPublisher<Search, Never> in
                self.service.search(query: query, page: self.page)
                    .asResult()
            }
            .receive(on: DispatchQueue.main)
            .share()
            .eraseToAnyPublisher()
    }()

    // MARK: - Initialization

    init(service: MultiSearchService) {
        self.service = service

        searchPublisher
            .map { result in

                switch result {
                case .success(let data):
                    return self.processData(data)

                case .failure(_):
                    self.canLoadNextPage = false
                    return []
                }
            }
            .assign(to: &$repos)

        $searchQuery
            .map { searchQuery in
            if searchQuery == "" || searchQuery != self.previousSearchDone {
                return 1
            } else {
                return self.page
            }
        }.assign(to: &$page)
    }

    // MARK: - Public Funtions

    func searchNextPageIfPossible() {
        guard
            canLoadNextPage
        else { return }

        self.service.search(query: searchQuery, page: self.page)
            .sink(receiveCompletion: onReceive,
                  receiveValue: onReceive)
            .store(in: &subscriptions)
    }

    func getPath(item: MultiSearchResultModel) -> String? {
        guard let mediaType = item.mediaType else { return nil }
        switch mediaType {
        case .movie:
            return item.posterPath

        case .person:
            return item.knownFor?.first?.posterPath

        case .tv:
            return item.posterPath
        }
    }

    func getTitle(item: MultiSearchResultModel) -> String? {
        guard let mediaType = item.mediaType else { return nil }
        switch mediaType {
        case .movie:
            return item.title

        case .person, .tv:
            return item.name
        }
    }

    func getMediaType(item: MultiSearchResultModel) -> String {
        item.mediaType?.rawValue.capitalized ?? ""
    }
    
    // MARK: - Private functions

    private func onReceive(_ completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break

        case .failure:
            self.canLoadNextPage = false
        }
    }

    private func onReceive(_ batch: MultiSearchModel) {
        repos = processData(batch)
    }

    private func processData(_ batch: MultiSearchModel) -> [MultiSearchResultModel] {
        if searchQuery != previousSearchDone {
            repos = []
        }
        page += 1
        previousSearchDone = searchQuery
        canLoadNextPage = (batch.totalPages ?? 0) >= page
        return repos + (batch.results ?? [])
    }
}

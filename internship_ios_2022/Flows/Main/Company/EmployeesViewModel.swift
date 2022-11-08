import Foundation

final class EmployeesViewModel {

    // MARK: - enums

    enum State {
        case initial
        case loading
        case error(Error)
        case loaded
    }

    // MARK: - properties

    var model: Model?
    var cache = URLCache()
    var stateChanged: ((State) -> Void)?
    private let networkService = NetworkService()
    private let decoder = JSONDecoder()
    private var state: State = .initial {
        didSet {
            stateChanged?(state)
        }
    }

    // MARK: - init

    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }

    // MARK: - functions

    func setupData() {
        state = .loading
        let urlString = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)

        if let data = cache.cachedResponse(for: request)?.data,
           let model = decode(data: data) {
            self.model = model
            self.state = .loaded
            return
        }
        cache.removeAllCachedResponses()
        networkService.fetchData(request: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                if let model = self.decode(data: data) {
                    self.model = model
                    self.state = .loaded
                }
            case .failure(let error):
                self.state = .error(error)
            }
        }
    }

    private func decode(data: Data) -> Model? {
        do {
            return try decoder.decode(Model.self, from: data)
        } catch let error {
            self.state = .error(error)
            return nil
        }
    }

}

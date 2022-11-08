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
    var stateChanged: ((State) -> Void)?
    private let urlCache = URLCache()
    private let cache = NSCache<NSString, NSDate>()
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
        cache.countLimit = 1

    }

    // MARK: - functions

    func loadData() {
        state = .loading
        let urlString = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        if let model = loadDataFromCache(request) {
            self.model = model
            self.state = .loaded
        } else {
            downloadData(request)
        }
    }

    private func downloadData(_ request: URLRequest) {
        networkService.fetchData(request: request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                if let model = self.decode(data: data) {
                    self.model = model
                    self.state = .loaded
                    let date = Date.now as NSDate
                    self.cache.setObject(date, forKey: "date")
                }
            case .failure(let error):
                self.state = .error(error)
            }
        }
    }

    private func loadDataFromCache(_ request: URLRequest) -> Model? {
        let cachedDate = cache.object(forKey: "date")
        let timeInterval = abs(cachedDate?.timeIntervalSinceNow ?? 9999)
        if let data = urlCache.cachedResponse(for: request)?.data,
           let model = decode(data: data) {
            if timeInterval > 3600 {
                urlCache.removeCachedResponses(since: Date(timeIntervalSince1970: 0))
            }
            return model
        }
        return nil
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

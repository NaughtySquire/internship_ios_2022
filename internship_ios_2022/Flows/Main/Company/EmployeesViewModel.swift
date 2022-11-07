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
        setData()
    }

    // MARK: - functions

    private func setData() {
        state = .loading
        let urlString = "https://run.mocky.io/v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
        guard let url = URL(string: urlString) else { return }
        networkService.fetchData(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                do {
                    self.model = try self.decoder.decode(Model.self, from: data)
                    self.state = .loaded
                } catch let error {
                    self.state = .error(error)
                }
            case .failure(let error):
                self.state = .error(error)
            }
        }
    }
}

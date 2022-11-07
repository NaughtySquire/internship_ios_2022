import Foundation

final class CompanyViewModel {

    // MARK: - enums

    enum State {
        case initial
        case loading
        case error
        case loaded
    }

    // MARK: - properties
    let networkService: NetworkServiceProtocol = CompanyNetworkService()
    var stateChanged: ((State) -> Void)?
    private var state: State = .initial {
        didSet {
            stateChanged?(state)
        }
    }

    // MARK: - init

    // MARK: - functions
}

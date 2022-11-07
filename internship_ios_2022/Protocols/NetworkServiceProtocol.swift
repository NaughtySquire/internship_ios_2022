import Foundation
protocol NetworkServiceProtocol {
    func fetchData(url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

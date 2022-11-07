import Foundation

struct CompanyNetworkService: NetworkServiceProtocol {

    // MARK: - properties

    let urlSession = URLSession(configuration: .default)

    // MARK: - NetworkServiceProtocol implementation

    func fetchData(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
				completion(.failure(error))
				    return
            }
            guard let data = data,
                  response != nil else {
                print("Что-то пошло не так.")
                return
            }
            completion(.success(data))
        }.resume()
    }
}

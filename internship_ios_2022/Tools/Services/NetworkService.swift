import Foundation

struct NetworkService {

    // MARK: - properties

    private let urlSession = URLSession(configuration: .default)

    // MARK: - functions

    func fetchData(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
				completion(.failure(error))
				    return
            }
            guard let data = data,
                  response != nil else {
                fatalError("Что-то пошло не так." +
                           "\n data: \(String(describing: data))" +
                           "\n response: \(String(describing: response))")
            }
            completion(.success(data))
        }.resume()
    }
}

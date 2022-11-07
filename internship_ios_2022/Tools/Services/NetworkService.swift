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
                print("Что-то пошло не так.")
                return
            }
            completion(.success(data))
        }.resume()
    }
}

import Foundation

struct NetworkService {

    // MARK: - properties

    private let urlSession = URLSession.shared
//    private let urlCache = URLCache.shared

    // MARK: - functions

    func fetchData(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        urlSession.dataTask(with: request) { data, response, error in
            if let error = error {
				completion(.failure(error))
				    return
            }
            guard let data = data,
                  response != nil else {
                fatalError("\n Fatal Error: Что-то пошло не так." +
                           "\n data: \(String(describing: data))" +
                           "\n response: \(String(describing: response))\n")
            }
//            let cachedData = CachedURLResponse(response: response!, data: data)
//            self.urlCache.storeCachedResponse(cachedData, for: request)
            completion(.success(data))
        }.resume()
    }
}

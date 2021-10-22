import Foundation

struct ResponseError: Error {
    var response: HTTPURLResponse
    init(_ response: HTTPURLResponse) {
        self.response = response
    }
}

func downloadData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        if let response = response as? HTTPURLResponse {
            guard response.statusCode == 200 else {
                completion(.failure(ResponseError(response)))
                return
            }
        }
        completion(.success(data!))
    }.resume()
}

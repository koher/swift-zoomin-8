import Foundation

struct ResponseError: Error {
    var statusCode: Int
}

func downloadData(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        if let response = response as? HTTPURLResponse {
            guard response.statusCode == 200 else {
                completion(.failure(ResponseError(statusCode: response.statusCode)))
                return
            }
        }
        completion(.success(data!))
    }.resume()
}

func downloadData(from url: URL) async throws -> Data {
    let (data, response) = try await URLSession.shared.data(from: url)
    if let response = response as? HTTPURLResponse {
        guard response.statusCode == 200 else {
            throw ResponseError(statusCode: response.statusCode)
        }
    }
    return data
}

import Foundation

enum FetchDataError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case dataConversionError
    case jsonDecodingError(Error)
}

func fetchBikes(from urlString: String, completion: @escaping (Result<[Bike], FetchDataError>) -> Void) {
    guard let url = URL(string: urlString) else {
        completion(.failure(.invalidURL))
        return
    }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        DispatchQueue.main.async {
            // Handle network errors
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }

            // Validate HTTP response and status code
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode), let data = data else {
                completion(.failure(.invalidResponse))
                return
            }

            // Decode the JSON data into an array of Book objects
            do {
                let bikes = try JSONDecoder().decode([Bike].self, from: data)
                completion(.success(bikes))
            } catch {
                completion(.failure(.jsonDecodingError(error)))
            }
        }
    }
    task.resume()
}


func fetchParts(from urlString: String, completion: @escaping (Result<[Part], FetchDataError>) -> Void) {
    guard let url = URL(string: urlString) else {
        completion(.failure(.invalidURL))
        return
    }

    let task = URLSession.shared.dataTask(with: url) { data, response, error in
        DispatchQueue.main.async {
            // Handle network errors
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }

            // Validate HTTP response and status code
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode), let data = data else {
                completion(.failure(.invalidResponse))
                return
            }

            // Decode the JSON data into an array of Book objects
            do {
                let parts = try JSONDecoder().decode([Part].self, from: data)
                completion(.success(parts))
            } catch {
                completion(.failure(.jsonDecodingError(error)))
            }
        }
    }
    task.resume()
}

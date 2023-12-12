import Foundation

enum FetchDataError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case dataConversionError
    case jsonDecodingError(Error)
}

//    let urlString = "http://192.168.1.45:8080/api/v1/bikes"
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
                let bikesDict = try JSONDecoder().decode([String: Bike].self, from: data)
                let bikesArray: [Bike] = Array(bikesDict.values)
                completion(.success(bikesArray))
            } catch {
                completion(.failure(.jsonDecodingError(error)))
            }
        }
    }
    task.resume()
}

// let urlString = "http://192.168.1.45:8080/api/v1/parts"
func fetchParts(from urlString: String, completion: @escaping (Result<BicycleComponents, FetchDataError>) -> Void) {
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
                let parts: BicycleComponents = try JSONDecoder().decode(BicycleComponents.self, from: data)
                completion(.success(parts))
            } catch {
                completion(.failure(.jsonDecodingError(error)))
            }
        }
    }
    task.resume()
}

func postBike(_ bike: Bike, to urlString: String, completion: @escaping (Result<Void, FetchDataError>) -> Void) {
    guard let url = URL(string: urlString) else {
        completion(.failure(.invalidURL))
        return
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    do {
        let jsonData = try JSONEncoder().encode(bike)
        request.httpBody = jsonData
    } catch {
        completion(.failure(.jsonDecodingError(error)))
        return
    }

    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        DispatchQueue.main.async {
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.invalidResponse))
                return
            }

            completion(.success(()))
        }
    }
    task.resume()
}

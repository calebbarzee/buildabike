import Foundation

// Define a custom error type for better error handling
enum FetchDataError: Error {
    case invalidURL
    case networkError(Error)
    case invalidResponse
    case dataConversionError
}

func fetchData(from urlString: String, completion: @escaping (Result<String, FetchDataError>) -> Void) {
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
            
            // Convert and return the data as a string
            if let result = String(data: data, encoding: .utf8) {
                completion(.success(result))
            } else {
                completion(.failure(.dataConversionError))
            }
        }
    }
    
    task.resume()
}

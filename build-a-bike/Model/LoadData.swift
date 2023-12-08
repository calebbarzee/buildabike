import Foundation

func loadBikeParts(completion: @escaping (Result<Part, Error>) -> Void) {
    let urlString = "http://localhost:8080/api/v1/parts"  // Adjust this URL as needed

    fetchData(from: urlString) { result in
        switch result {
        case .success(let jsonString):
            do {
                // Decode JSON string into BikeParts
                let data = Data(jsonString.utf8)
                let decoder = JSONDecoder()
                let bikeParts = try decoder.decode(Part.self, from: data)
                completion(.success(bikeParts))
            } catch {
                completion(.failure(error))
            }

        case .failure(let error):
            completion(.failure(error))
        }
    }
}

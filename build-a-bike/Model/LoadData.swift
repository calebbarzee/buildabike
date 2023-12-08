import Foundation

func loadBikeParts(completion: @escaping (Result<[Part], FetchDataError>) -> Void) {
    let urlString = "http://192.168.1.45:8080/api/v1/parts"

    fetchData(from: urlString) { result in
        switch result {
        case .success(let jsonString):
            do {
                let data = Data(jsonString.utf8)
                let decoder = JSONDecoder()
                let bikeParts = try decoder.decode([Part].self, from: data)
                completion(.success(bikeParts))
            } catch {
                completion(.failure(.jsonDataConversionError))
            }

        case .failure(let error):
            completion(.failure(error))
        }
    }
}


func loadBikes(completion: @escaping (Result<[UUID: Bike], FetchDataError>) -> Void) {
    let urlString = "http://192.168.1.45:8080/api/v1/bikes"

    fetchData(from: urlString) { result in
        switch result {
        case .success(let jsonString):
            do {
                let data = Data(jsonString.utf8)
                let decoder = JSONDecoder()
                let bikes = try decoder.decode([UUID: Bike].self, from: data)
                completion(.success(bikes))
            } catch {
                completion(.failure(.jsonDataConversionError))
                print("Error info: \(error)")
            }

        case .failure(let error):
            completion(.failure(error))
        }
    }
}


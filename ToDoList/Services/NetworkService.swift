    import Foundation

    final class NetworkService {
        static let shared = NetworkService()
        
        func fetchTodosFromAPI(completion: @escaping (Result<[Todo], Error>) -> Void) {
            guard let url = URL(string: "https://dummyjson.com/todos") else { return }
            
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                    return
                }
                
                do {
                    let decodedData = try JSONDecoder().decode(Todos.self, from: data)
                    completion(.success(decodedData.todos))
                } catch {
                    completion(.failure(error))
                }
            }.resume()
        }
    }

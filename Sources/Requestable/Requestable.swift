import Foundation
import Combine

public protocol Requestable {
    func request<T: Codable>(_ request: URLRequest) -> AnyPublisher<T, NetworkError>
}

extension Requestable {
    public func request<T: Codable>(_ request: URLRequest) -> AnyPublisher<T, NetworkError> {
        let session = Session.shared.session
        return session.dataTaskPublisher(for: request)
            .tryMap { (data, response) -> Data in
                if let httpResponse = response as? HTTPURLResponse {
                    guard (200..<300) ~= httpResponse.statusCode else {
                        throw NetworkError.invalidResponse(statusCode: httpResponse.statusCode)
                    }
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error -> NetworkError in
                if let decodingError = error as? DecodingError {
                    return NetworkError.decodingError(errorDescription: (decodingError as NSError).debugDescription)
                }
                return NetworkError.genericError(errorDescription: error.localizedDescription)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

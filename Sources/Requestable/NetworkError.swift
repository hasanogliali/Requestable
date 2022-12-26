import Foundation

public enum NetworkError: Error {
    case decodingError(errorDescription: String)
    case genericError(errorDescription: String)
    case invalidResponse(statusCode: Int)
}

import Foundation

extension URL {

    public func addQueryParameters(_ params: [String: String]) -> URL {
        guard params.count > 0 else { return self }
        guard var urlComponents = URLComponents(string: absoluteString) else {
            fatalError("Could not create URLComponents using URL: '\(absoluteURL)'")
        }
        urlComponents.queryItems = params.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        guard let url = urlComponents.url else {
            fatalError("Could not create URL")
        }
        return url
    }
}

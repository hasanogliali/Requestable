import Foundation

public enum RequestCreator {
    case `default`
    // TODO: Setting timeout
    func createURLRequest(with request: RequestWithQueryParams) -> URLRequest {
        let url = request.url.addQueryParameters(request.queryParams)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        // Headers
        var headers = request.headers
        headers["Content-Type"] = NetworkContentType.json.value
        urlRequest.allHTTPHeaderFields = headers

        urlRequest.timeoutInterval = Session.shared.timeout.request
        urlRequest.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        return urlRequest
    }

    func createURLRequest(with request: RequestWithBody) -> URLRequest {
        var urlRequest = URLRequest(url: request.url)
        urlRequest.httpMethod = request.httpMethod.rawValue
        // Headers
        var headers = request.headers
        headers["Content-Type"] = request.contentType.value
        urlRequest.allHTTPHeaderFields = headers

        urlRequest.timeoutInterval = Session.shared.timeout.request
        urlRequest.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        urlRequest.httpBody = request.body
        return urlRequest
    }
}

public extension RequestCreator {
    struct RequestWithQueryParams {
        let url: URL
        let httpMethod: HTTPMethod
        var queryParams: [String: String] = [:]
        var headers: [String: String] = [:]
    }

    struct RequestWithBody {
        let url: URL
        let httpMethod: HTTPMethod
        let body: Data?
        var headers: [String: String] = [:]
        var contentType: NetworkContentType = .json
    }
}

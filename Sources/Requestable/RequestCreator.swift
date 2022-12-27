import Foundation

public enum RequestCreator {
    case `default`

    public func createURLRequest(with request: RequestWithQueryParams) -> URLRequest {
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

    public func createURLRequest(with request: RequestWithBody) -> URLRequest {
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

extension RequestCreator {
    public struct RequestWithQueryParams {

        let url: URL
        let httpMethod: HTTPMethod
        let queryParams: [String: String]
        let headers: [String: String]

        public init(
            url: URL,
            httpMethod: HTTPMethod,
            queryParams: [String: String] = [:],
            headers: [String: String] = [:]
        ){
            self.url = url
            self.httpMethod = httpMethod
            self.queryParams = queryParams
            self.headers = headers
        }
    }

    public struct RequestWithBody {

        let url: URL
        let httpMethod: HTTPMethod
        let body: Data?
        let headers: [String: String]
        let contentType: NetworkContentType

        public init(
            url: URL,
            httpMethod: HTTPMethod,
            body: Data?,
            headers: [String: String] = [:],
            contentType: NetworkContentType = .json
        ){
            self.url = url
            self.httpMethod = httpMethod
            self.body = body
            self.headers = headers
            self.contentType = contentType
        }
    }
}

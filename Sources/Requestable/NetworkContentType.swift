public enum NetworkContentType: String {
    case json
    case urlencoded

    var value: String {
        switch self {
        case .json: return "application/json"
        case .urlencoded: return "application/x-www-form-urlencoded"
        }
    }
}

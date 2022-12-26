import Foundation

final class Session {
    static var instance: Session?
    static var shared: Session {
        guard let instance = instance else {
            self.instance = Session()
            return self.instance!
        }
        return instance
    }

    var session: URLSession

    var timeout: TimeOut {
        didSet {
            session.configuration.timeoutIntervalForRequest = timeout.request
            session.configuration.timeoutIntervalForResource = timeout.resource
        }
    }

    required init() {
        let configuration = URLSession.shared.configuration
        timeout = TimeOut(request: 60, resource: 60)
        session = URLSession(configuration: configuration)
    }

    struct TimeOut {
        var request: TimeInterval
        var resource: TimeInterval
    }
}

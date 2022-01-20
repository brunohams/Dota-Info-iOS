import Foundation

class Logger {

    private let tag: String
    private let isDebug: Bool

    private init(tag: String, isDebug: Bool) {
        self.tag = tag
        self.isDebug = isDebug
    }

    func log(message: String) {
        if isDebug {
            print("LOG: \(message)")
        } else {
            // LOG INTO PROD
            // TODO
        }
    }

    static func createDebugLogger(tag: String) -> Logger {
        return Logger.init(tag: tag, isDebug: true)
    }

    static func createProductionLogger(tag: String) -> Logger {
        return Logger.init(tag: tag, isDebug: false)
    }

}
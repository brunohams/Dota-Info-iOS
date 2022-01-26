import Foundation

class LoggerDebug: Logger {

    private let tag: String

    init(tag: String) {
        self.tag = tag
    }

    func log(message: String) {
        print("\(tag) -: \(message)")
    }

}
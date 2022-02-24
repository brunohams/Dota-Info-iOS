@testable import Domain

class LoggerFirebase: Logger {

    private let tag: String
    private let firebaseInstance: String

    init(tag: String, firebaseInstance: String) {
        self.tag = tag
        self.firebaseInstance = firebaseInstance
    }

    func log(message: String) {
        // LOG INTO PROD
    }

}

@testable import Domain

class LoggerFirebaseFactory: LoggerFactory {

    func createLogger(tag: String) -> Logger {
        return LoggerFirebase(tag: tag, firebaseInstance: "prod")
    }

}

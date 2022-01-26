import Foundation

class LoggerFirebaseFactory: LoggerFactory {

    func createLogger(tag: String) -> Logger {
        return LoggerFirebase(tag: tag, firebaseInstance: "prod")
    }

}

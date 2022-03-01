@testable import Shared_Domain

class LoggerDebugFactory: LoggerFactory {

    func createLogger(tag: String) -> Logger {
        return LoggerDebug(tag: tag)
    }

}

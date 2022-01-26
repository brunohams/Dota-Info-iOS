import Foundation

protocol LoggerFactory {

    func createLogger(tag: String) -> Logger

}

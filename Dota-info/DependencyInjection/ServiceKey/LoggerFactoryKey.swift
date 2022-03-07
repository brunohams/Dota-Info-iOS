@testable import Common
@testable import Shared_Domain

struct LoggerFactoryKey: InjectionKey {
    typealias Value = LoggerFactory
    static var currentValue: LoggerFactory = LoggerDebugFactory()
}

extension InjectedValues {
    var loggerFactory: LoggerFactory {
        get { Self[LoggerFactoryKey.self] }
        set { Self[LoggerFactoryKey.self] = newValue }
    }
}

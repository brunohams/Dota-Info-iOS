@testable import Core
@testable import DataSource

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
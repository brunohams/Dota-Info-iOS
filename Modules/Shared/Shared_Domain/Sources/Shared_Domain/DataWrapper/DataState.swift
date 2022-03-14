import Foundation

enum DataState<T> {

    case error(_ error: ErrorDetail)
    case success(_ data: T)
    case progress(_ progressState: ProgressState)

}

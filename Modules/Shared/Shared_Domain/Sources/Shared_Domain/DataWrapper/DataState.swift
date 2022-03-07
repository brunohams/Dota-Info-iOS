import Foundation

enum DataState<T> {

    case error(uiComponent: UIComponent?)
    case success(_ data: T?)
    case progress(_ progressState: ProgressState)

}

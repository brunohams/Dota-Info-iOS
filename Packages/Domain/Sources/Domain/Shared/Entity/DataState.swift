import Foundation

enum DataState<T> {

    case response(uiComponent: UIComponent)
    case data(_ data: T?)
    case progress(_ progressState: ProgressState)

}

import Foundation

enum DataState<T> {

    case response(uiComponent: UIComponent)
    case data(data: T)
    case loading(progressState: ProgressState)

}
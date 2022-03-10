import Foundation
import ReSwift

class AppReducer {
    static func reducer(action: Action, state: AppState?) -> AppState {
        var state = state ?? AppState()

        switch action {
        case is IncreaseErrorQuantityAction:
            state.numberOfErrors += 1
        default:
            break
        }

        return state
    }
}

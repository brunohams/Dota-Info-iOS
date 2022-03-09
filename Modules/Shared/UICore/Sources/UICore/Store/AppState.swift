import ReSwift
@testable import Hero_Domain
@testable import Shared_Domain

struct AppState {
    var heroListState: HeroListState = HeroListState()
}



func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState(
        heroListState: heroListReducer(action, state: state?.heroListState)
    )
}

let store = Store(
    reducer: appReducer,
    state: AppState(),
    middleware: [] // Maybe put an action logger?
)


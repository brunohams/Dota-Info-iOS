import ReSwift
@testable import Hero_Domain
@testable import Shared_Domain

class AppStore {
    static let shared: Store<AppState> = {
        let instance = Store(
            reducer: AppReducer.reducer,
            state: AppState(),
            middleware: [] // Maybe put an action logger?
        )
        return instance
    }()
}
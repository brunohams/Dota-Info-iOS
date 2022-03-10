import Foundation
import ReSwift

class HeroStore {
    static let shared: Store<HeroState> = {
        let instance = Store(
                reducer: reducer,
                state: HeroState(),
                middleware: [] // Maybe put an action logger?
        )
        return instance
    }()

    static func reducer(action: Action, state: HeroState?) -> HeroState {
        return HeroState(
            heroListState: HeroListReducer.reducer(action, state: state?.heroListState)
        )
    }
}

import Foundation
import RxSwift
import ReSwift
@testable import Shared_Domain
@testable import Hero_Domain
@testable import UICore

class HeroDetailViewModel: ObservableObject, GetHeroOutput, StoreSubscriber {

    @Published var state: HeroDetailState = HeroDetailState()

    init() {
        HeroStore.shared.subscribe(self)
    }

    func newState(state: HeroState) {
        self.state = state.heroDetailState
    }

    func didReceive(hero: Hero) {
        HeroStore.shared.dispatch(
            ReceiveHeroAction(hero: hero)
        )
    }

    func didReceive(error: ErrorDetail) {
        HeroStore.shared.dispatch(
            ReceiveErrorAction(error: error)
        )
    }

    func didReceive(progress: ProgressState) {
//        HeroStore.shared.dispatch(
//            ReceiveProgressAction(progress: progress)
//        )
    }
}

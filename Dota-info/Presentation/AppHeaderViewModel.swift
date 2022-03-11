import Foundation
import RxSwift
import ReSwift
@testable import Shared_Domain
@testable import Hero_Domain
@testable import UICore

class AppHeaderViewModel: ObservableObject, StoreSubscriber {

    @Published var state: AppState = AppState()

    init() {
        AppStore.shared.subscribe(self)
    }

    func newState(state: AppState) {
        self.state = state
    }


}

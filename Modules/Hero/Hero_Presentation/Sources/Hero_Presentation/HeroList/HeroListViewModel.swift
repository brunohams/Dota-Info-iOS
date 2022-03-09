import Foundation
import RxSwift
import ReSwift
@testable import Shared_Domain
@testable import Hero_Domain
@testable import UICore

class HeroListViewModel: ObservableObject, GetHeroesOutput, StoreSubscriber {

    typealias StoreSubscriberStateType = AppState
    private var disposeBag = DisposeBag()

    @Published var state: HeroListState = HeroListState()

    init() {
        store.subscribe(self)
    }
    
    func newState(state: AppState) {
        self.state = state.heroListState
    }

    func didReceive(heroes: [Hero]) {
        store.dispatch(ReceiveHeroesAction(heroes: heroes))
    }

    func didReceive(error: ErrorDetail) {
        store.dispatch(ReceiveErrorAction(error: error))
    }

    func didReceive(progress: ProgressState) {
        store.dispatch(ReceiveProgressAction(progress: progress))
    }



//    func didReceiveObservable(observable: Observable<DataState<[Hero]>>) {
//        observable
//            .observe(on: MainScheduler.instance)
//            .subscribe(onNext: { state in
//                switch (state) {
//                    case .error(let uiComponent):
//                        store.dispatch(ReceiveErrorAction(uiComponent: uiComponent))
//                    case .success(let heroes):
//                        if let heroes = heroes {
//                            store.dispatch(ReceiveHeroesAction(heroes: heroes))
//                        }
//                    case .progress(let progress):
//                        store.dispatch(ReceiveProgressAction(progress: progress))
//                }
//
//            }).disposed(by: disposeBag)
//    }


}

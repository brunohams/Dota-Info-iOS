import Foundation
import RxSwift
import ReSwift
@testable import Shared_Domain
@testable import Hero_Domain
@testable import UICore

class HeroListViewModel: ObservableObject, GetHeroesOutput {

    @Published var state: HeroListState = HeroListState()

    func didReceive(heroes: [Hero]) {
        state.heroes = heroes
        state = state
    }

    func didReceive(error: ErrorDetail) {
        state.dialog = UIComponent.Dialog(title: error.title, description: error.description)
        state = state
    }

    func didReceive(progress: ProgressState) {
        state.progressBar = progress
        state = state
    }

    func dismissDialog() {
        state.dialog = UIComponent.None(message: "")
        state = state
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

import Foundation
import RxSwift
import ReSwift
@testable import Shared_Domain
@testable import Hero_Domain
@testable import UICore

class HeroListViewModel: ObservableObject, GetHeroesOutput {

    @Published var state: HeroListState = HeroListState()
    private let disposeBag = DisposeBag()

    func didReceiveObservable(observable: Observable<DataState<[Hero]>>) {
        observable
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { state in
                switch (state) {
                    case .error(let error):
                        self.show(error: error)
                    case .success(let heroes):
                        self.show(heroes: heroes)
                    case .progress(let progress):
                        self.show(progress: progress)
                }

            }).disposed(by: disposeBag)
    }

    func show(heroes: [Hero]) {
        state.heroes = heroes
        state = state
    }

    func show(error: ErrorDetail) {
        state.dialog = UIComponent.Dialog(title: error.title, description: error.description)
        state = state
    }

    func show(progress: ProgressState) {
        state.progressBar = progress
        state = state
    }

    func dismissDialog() {
        state.dialog = UIComponent.None(message: "")
        state = state
    }

}

import Foundation
import RxSwift
import Combine

class HeroListViewModel: ObservableObject {

    var disposeBag = DisposeBag()
    @Published var state: HeroListState = HeroListState()

    // TODO - Inject that later
    let getHeroes: GetHeroes
    let logger: Logger

    init (getHeroes: GetHeroes, logger: Logger) {
        self.getHeroes = getHeroes
        self.logger = logger

        getHeroesList()
    }

    func getHeroesList() {
        getHeroes.execute()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] state in

                self?.logger.log(message: "Event emitted: \(state)")

                switch (state) {
                    case .response(uiComponent: let uiComponent):
                        self?.handleResponseState(uiComponent: uiComponent)
                    case .data(data: let data):
                        self?.updateDataState(data: data)
                    case .loading(progressState: let progressState):
                        self?.updateProgressState(progress: progressState)
                }

            }).disposed(by: disposeBag)
    }

    func handleResponseState(uiComponent: UIComponent) {
        switch (uiComponent) {
            case let dialog as UIComponent.Dialog:
                show(dialog: dialog)
                return

            case let none as UIComponent.None:
                logger.log(message: none.message)
                return

            default: return
        }
    }

    func updateDataState(data: [Hero]?) {
        guard let data = data else { return }
        state.heroes = data
        state = state
    }

    func updateProgressState(progress: ProgressState) {
        state.progressBar = progress
        state = state
    }

    func show(dialog: UIComponent.Dialog) {
        dialog.title
        dialog.description
        state.dialog = dialog
        state = state
    }

}
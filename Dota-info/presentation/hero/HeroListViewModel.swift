import Foundation
import Combine
import RxSwift
@testable import Core
@testable import Domain

class HeroListViewModel: ObservableObject {

    @Published var state: HeroListState = HeroListState()

    let getHeroes: GetHeroes
    let logger: Logger

    init (getHeroes: GetHeroes, loggerFactory: LoggerFactory) {
        self.getHeroes = getHeroes
        self.logger = loggerFactory.createLogger(tag: "HeroListViewModel")

        getHeroesList()
    }

    func getHeroesList() {
//        getHeroes.subject
//            .subscribe(on: DispatchQueue.global(qos: .background))
//            .receive(on: DispatchQueue.main)
//            .sink { state in

//            }
        getHeroes.execute()
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .subscribe(onNext: { state in
                switch (state) {
                    case .response(let uiComponent):
                        self.handleResponseState(uiComponent: uiComponent)
                    case .data(let data):
                        self.updateDataState(data: data)
                    case .loading(let progressState):
                        self.updateProgressState(progress: progressState)
                }
            })
            .dispose()
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

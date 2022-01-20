import Foundation
import RxSwift

class HeroListViewModel: ObservableObject {

    // TODO - Inject that later
    let getHeroes: GetHeroes
    let logger: Logger

    init (getHeroes: GetHeroes, logger: Logger) {
        self.getHeroes = getHeroes
        self.logger = logger

        self.getHeroesList()
    }

    @Published private(set) var state: HeroListState = HeroListState()

    func getHeroesList() {
        getHeroes.execute().subscribe { event in

            guard let state = event.element else { return }

            switch (state) {
                case .response(uiComponent: let uiComponent):
                    self.handleResponseState(uiComponent: uiComponent)
                case .data(data: let data):
                    self.handleDataState(data: data)
                case .loading(progressState: let progressState):
                    self.handleLoadingState(progress: progressState)
            }

        }
    }

    func handleResponseState(uiComponent: UIComponent) {
        switch uiComponent {
            case .dialog(uiComponent: let uiComponent):
                showDialog(uiComponent: uiComponent)
            case .none(uiComponent: let uiComponent):
                logger.log(message: uiComponent.message)
        }
    }

    func handleDataState(data: [Hero]) {
        // TODO Populate list
        print("data = \(data)")
    }

    func handleLoadingState(progress: ProgressState) {
        // TODO Show
        self.state.progressBar = progress
    }

    func showDialog(uiComponent: UIComponent.Dialog) {
        // TODO Show dialog with
        uiComponent.title
        uiComponent.description
    }

    func logInformation(uiComponent: UIComponent.None) {
        // TODO log info
        uiComponent.message
    }

}
import Foundation
@testable import Shared_Domain
@testable import Hero_Domain

class HeroListViewModel: ObservableObject, GetHeroesOutput {
    
    @Published var state: HeroListState = HeroListState()

    let getHeroes: GetHeroes

    init (getHeroes: GetHeroes) {
        self.getHeroes = getHeroes
                
        getHeroes.execute(output: self)
    }

    func didGetHeroes(heroes: [Hero]) {
        state.heroes = heroes
    }
    
    func didGetError(uiComponent: UIComponent) {
        switch (uiComponent) {
            case let dialog as UIComponent.Dialog:
                show(dialog: dialog)
                return

            default: return
        }
    }
    
    func didGetProgress(progress: ProgressState) {
        state.progressBar = progress
        updateState()
    }

    private func show(dialog: UIComponent.Dialog) {
        state.dialog = dialog
        updateState()
    }
    
    /// Force update state
    private func updateState() {
        DispatchQueue.main.async() {
            self.state = self.state
        }
    }

}

import Foundation
import RxSwift
import ReSwift
@testable import Shared_Domain
@testable import Hero_Domain
@testable import UICore

class HeroDetailViewModel: ObservableObject, GetHeroOutput {

    @Published var state: HeroDetailState = HeroDetailState()

    func didReceive(hero: Hero) {
        state.heroName = hero.localizedName
        state.heroId = String(hero.id)
        state.heroImg = hero.img
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

    func didNotFoundHero(withId: Int) {
        state.dialog = UIComponent.Dialog(title: "Hero not Found", description: "Hero with id \(withId) was not found")
        state = state
    }

    func dismissDialog() {
        state.dialog = UIComponent.None(message: "")
        state = state
    }
}

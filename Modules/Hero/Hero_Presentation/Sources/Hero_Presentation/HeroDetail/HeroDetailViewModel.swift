import Foundation
import RxSwift
import ReSwift
@testable import Shared_Domain
@testable import Hero_Domain
@testable import UICore

class HeroDetailViewModel: ObservableObject, GetHeroOutput {

    @Published var state: HeroDetailState = HeroDetailState()

    func didReceive(hero: Hero) {
        DispatchQueue.main.async {
            self.state.heroName = hero.localizedName
            self.state.heroId = String(hero.id)
            self.state.heroImg = hero.img
            self.state = self.state
        }
    }

    func didReceive(error: ErrorDetail) {
        DispatchQueue.main.async {
            self.state.dialog = UIComponent.Dialog(title: error.title, description: error.description)
            self.state = self.state
        }
    }

    func didReceive(progress: ProgressState) {
        DispatchQueue.main.async {
            self.state.progressBar = progress
            self.state = self.state
        }
    }

    func didNotFoundHero(withId: Int) {
        DispatchQueue.main.async {
            self.state.dialog = UIComponent.Dialog(title: "Hero not Found", description: "Hero with id \(withId) was not found")
            self.state = self.state
        }
    }

    func dismissDialog() {
        state.dialog = UIComponent.None(message: "")
        state = state
    }
}

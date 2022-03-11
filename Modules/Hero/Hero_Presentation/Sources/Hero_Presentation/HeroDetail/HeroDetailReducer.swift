import ReSwift
@testable import Shared_Domain
@testable import Hero_Domain
import FirebaseAnalytics

class HeroDetailReducer {

    static func reducer(_ action: Action, state: HeroDetailState?) -> HeroDetailState {
        let state = state ?? HeroDetailState()

        switch action {

            case let action as ReceiveHeroAction:
                let hero = action.hero
                state.heroId = String(hero.id)
                state.heroName = hero.localizedName
                state.heroImg = hero.img
                Analytics.logEvent(action.tag, parameters: nil)

            case let action as ReceiveProgressAction:
                let progress = action.progress
                state.progressBar = progress

            case let action as ReceiveErrorAction:
                let error = action.error
                state.dialog = UIComponent.Dialog(title: error.title, description: error.description)
                Analytics.logEvent(action.tag, parameters: nil)

        default: break

        }

        return state
    }
}

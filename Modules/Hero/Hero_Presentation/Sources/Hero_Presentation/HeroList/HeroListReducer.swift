import ReSwift
@testable import Shared_Domain
@testable import Hero_Domain
import FirebaseAnalytics

class HeroListReducer {

    static func reducer(_ action: Action, state: HeroListState?) -> HeroListState {
        let state = state ?? HeroListState()

        switch action {

        case let action as RequestHeroesAction:
            DispatchQueue.global(qos: .background).async( execute: {
                action.useCase.execute()
            })
            Analytics.logEvent(action.tag, parameters: nil)

        case let action as ReceiveHeroesAction:
            Analytics.logEvent(action.tag, parameters: nil)
            state.heroes = action.heroes

        case let action as ReceiveProgressAction:
            state.progressBar = action.progress

        case let action as ReceiveErrorAction:
            state.dialog = UIComponent.Dialog(title: action.error.title, description: action.error.description)

        case _ as DismissDialogAction:
            state.dialog = UIComponent.None(message: "")

        case _ as ThrowDummyErrorAction:
            state.dialog = UIComponent.Dialog(title: "Dummy", description: "This is a dummy error example =D")

        default: break

        }

        return state
    }

}

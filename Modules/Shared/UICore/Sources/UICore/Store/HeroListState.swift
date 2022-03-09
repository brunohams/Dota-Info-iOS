import ReSwift
@testable import Shared_Domain
@testable import Hero_Domain
import FirebaseAnalytics

class HeroListState {
    var heroes: [Hero] = []
    var progressBar: ProgressState = ProgressState.idle
    var dialog: UIComponent = UIComponent.None(message: "")
}

struct ReceiveHeroesAction: Action {
    let tag = "receive_heroes"
    var heroes: [Hero]
}

struct RequestHeroesAction: Action {
    let tag = "request_heroes"
    let getHeroesUseCase: GetHeroesUseCase
}

struct DismissDialogAction: Action {
    let tag = "dismiss_dialog_action"
}

struct ThrowDummyErrorAction: Action {}

struct ReceiveProgressAction: Action {
    let tag = "receive_progress"
    let progress: ProgressState
}

struct ReceiveErrorAction: Action {
    let tag = "receive_error"
    let error: ErrorDetail
}


func heroListReducer(_ action: Action, state: HeroListState?) -> HeroListState {
    let state = state ?? HeroListState()
        
    switch action {
        
        case let action as RequestHeroesAction:
            DispatchQueue.global(qos: .background).async( execute: {
                action.getHeroesUseCase.execute()
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

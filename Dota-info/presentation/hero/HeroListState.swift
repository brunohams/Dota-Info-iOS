import Foundation

class HeroListState {
    var heroes: [Hero] = []
    var progressBar: ProgressState = ProgressState.idle
    var dialog: UIComponent = UIComponent.None(message: "")
}
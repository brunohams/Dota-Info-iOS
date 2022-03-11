import Foundation
@testable import Shared_Domain

class HeroDetailState {
    var heroName: String = ""
    var heroImg: String = ""
    var heroId: String = ""
    var progressBar: ProgressState = ProgressState.idle
    var dialog: UIComponent = UIComponent.None(message: "")
}

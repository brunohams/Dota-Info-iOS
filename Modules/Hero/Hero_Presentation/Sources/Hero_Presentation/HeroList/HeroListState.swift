import Foundation
@testable import Shared_Domain
@testable import Hero_Domain
@testable import UICore

class HeroListState {
    var heroes: [Hero] = []
    var progressBar: ProgressState = ProgressState.idle
    var dialog: UIComponent = UIComponent.None(message: "")
}

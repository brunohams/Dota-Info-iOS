import Foundation
import ReSwift
@testable import Hero_Domain
@testable import Shared_Domain

struct ReceiveHeroesAction: Action {
    let tag = "receive_heroes"
    var heroes: [Hero]
}
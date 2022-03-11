import Foundation
import ReSwift
@testable import Shared_Domain
@testable import Hero_Domain

struct ReceiveHeroAction: Action {
    let tag = "receive_hero"
    let hero: Hero
}
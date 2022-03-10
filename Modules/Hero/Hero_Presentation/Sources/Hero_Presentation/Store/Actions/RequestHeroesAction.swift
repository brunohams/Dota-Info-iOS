import Foundation
import ReSwift
@testable import Shared_Domain
@testable import Hero_Domain

struct RequestHeroesAction: Action {
    let tag = "request_heroes"
    let useCase: GetHeroesUseCase
}
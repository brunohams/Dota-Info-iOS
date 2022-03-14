import Foundation
import RxSwift
@testable import Shared_Domain

protocol GetHeroOutput {
    func didReceive(hero: Hero)
    func didNotFoundHero(heroId: Int)
    func didReceive(error: ErrorDetail)
    func didReceive(progress: ProgressState)
}

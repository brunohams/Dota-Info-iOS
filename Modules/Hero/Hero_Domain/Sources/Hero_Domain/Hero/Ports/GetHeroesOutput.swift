import Foundation
import RxSwift
@testable import Shared_Domain

protocol GetHeroesOutput: ErrorOutput, ProgressOutput {
    
    func didGetHeroes(heroes: [Hero])
    
}

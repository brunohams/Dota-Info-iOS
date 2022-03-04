import Foundation
import RxSwift
@testable import Shared_Domain

protocol GetHeroesOutputable {
    
    func didGetHeroes(heroes: [Hero])
    func didGetError(uiComponent: UIComponent)
    func didGetProgress(progress: ProgressState)
    
}

import Foundation
import RxSwift
@testable import Shared_Domain

protocol GetHeroesOutput {
    func didReceiveObservable(observable: Observable<DataState<[Hero]>>)
}

@testable import UICore

struct HeroListViewModelKey: InjectionKey {
    typealias Value = HeroListViewModel
    static var currentValue: HeroListViewModel = HeroListViewModel()
}

extension InjectedValues {
    var heroListViewModel: HeroListViewModel {
        get { Self[HeroListViewModelKey.self] }
        set { Self[HeroListViewModelKey.self] = newValue }
    }
}
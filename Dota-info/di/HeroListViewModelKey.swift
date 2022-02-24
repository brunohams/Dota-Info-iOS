@testable import Core

struct HeroListViewModelKey: InjectionKey {
    typealias Value = HeroListViewModel
    static var currentValue: HeroListViewModel = HeroListViewModel(
            getHeroes: GetHeroesKey.currentValue,
            loggerFactory: LoggerFactoryKey.currentValue
    )
}

extension InjectedValues {
    var heroListViewModel: HeroListViewModel {
        get { Self[HeroListViewModelKey.self] }
        set { Self[HeroListViewModelKey.self] = newValue }
    }
}

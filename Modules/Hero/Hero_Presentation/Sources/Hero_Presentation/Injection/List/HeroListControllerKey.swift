@testable import UICore
@testable import Hero_Domain

struct HeroListControllerKey: InjectionKey {
    typealias Value = HeroListController
    static var currentValue: HeroListController = HeroListController(
            viewModel: HeroListViewModelKey.currentValue,
            getHeroesUseCase: GetHeroesUseCase(
                    heroService: HeroServiceKey.currentValue,
                    loggerFactory: LoggerFactoryKey.currentValue,
                    output: HeroListViewModelKey.currentValue
            )
    )
}

extension InjectedValues {
    var heroListController: HeroListController {
        get { Self[HeroListControllerKey.self] }
        set { Self[HeroListControllerKey.self] = newValue }
    }
}

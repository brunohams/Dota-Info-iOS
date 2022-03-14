@testable import UICore
@testable import Hero_Domain

struct HeroDetailControllerKey: InjectionKey {
    typealias Value = HeroDetailController
    static var currentValue: HeroDetailController = HeroDetailController(
            viewModel: HeroDetailViewModelKey.currentValue,
            getHeroUseCase: GetHeroUseCase(
                    heroService: HeroServiceKey.currentValue,
                    loggerFactory: LoggerFactoryKey.currentValue,
                    output: HeroDetailViewModelKey.currentValue
            )
    )
}

extension InjectedValues {
    var heroDetailController: HeroDetailController {
        get { Self[HeroDetailControllerKey.self] }
        set { Self[HeroDetailControllerKey.self] = newValue }
    }
}

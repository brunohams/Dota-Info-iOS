@testable import Common
@testable import Hero_Domain
@testable import Hero_Data
@testable import UICore

struct HeroDetailViewKey: InjectionKey {
    typealias Value = HeroDetailView
    static var currentValue: HeroDetailView = HeroDetailView(
            viewModel: HeroDetailViewModelKey.currentValue,
            getHeroUseCase: GetHeroUseCase(
                    heroService: HeroServiceKey.currentValue,
                    loggerFactory: LoggerFactoryKey.currentValue,
                    output: HeroDetailViewModelKey.currentValue)
    )
}

extension InjectedValues {
    var heroDetailView: HeroDetailView {
        get { Self[HeroDetailViewKey.self] }
        set { Self[HeroDetailViewKey.self] = newValue }
    }
}

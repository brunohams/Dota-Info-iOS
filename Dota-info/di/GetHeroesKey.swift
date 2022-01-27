@testable import Core
@testable import DataSource
@testable import Interactors

struct GetHeroesKey: InjectionKey {
    typealias Value = GetHeroes
    static var currentValue: GetHeroes = GetHeroes(
            heroService: HeroServiceKey.currentValue,
            loggerFactory: LoggerFactoryKey.currentValue
    )
}

extension InjectedValues {
    var getHeroes: GetHeroes {
        get { Self[GetHeroesKey.self] }
        set { Self[GetHeroesKey.self] = newValue }
    }
}
@testable import Core
@testable import Domain
@testable import DataSource

struct HeroServiceKey: InjectionKey {
    typealias Value = HeroService
    static var currentValue: HeroService = HeroServiceFake.init(responseType: .goodData)
}

extension InjectedValues {
    var heroService: HeroService {
        get { Self[HeroServiceKey.self] }
        set { Self[HeroServiceKey.self] = newValue }
    }
}

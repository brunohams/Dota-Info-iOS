@testable import UICore
@testable import Hero_Domain
@testable import Hero_Data

struct HeroServiceKey: InjectionKey {
    typealias Value = HeroService
    static var currentValue: HeroService = HeroServiceFake(responseType: .goodData)
}

extension InjectedValues {
    var heroService: HeroService {
        get { Self[HeroServiceKey.self] }
        set { Self[HeroServiceKey.self] = newValue }
    }
}

@testable import UICore
@testable import Hero_Presentation

struct HeroDetailViewModelKey: InjectionKey {
    typealias Value = HeroDetailViewModel
    static var currentValue: HeroDetailViewModel = HeroDetailViewModel()
}

extension InjectedValues {
    var heroDetailViewModel: HeroDetailViewModel {
        get { Self[HeroDetailViewModelKey.self] }
        set { Self[HeroDetailViewModelKey.self] = newValue }
    }
}

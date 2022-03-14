@testable import Common
@testable import Hero_Domain
@testable import Hero_Data
@testable import UICore

struct HeroDetailViewKey: InjectionKey {
    typealias Value = HeroDetailView
    static var currentValue: HeroDetailView = HeroDetailView(
            viewModel: HeroDetailViewModelKey.currentValue,
            controller: HeroDetailControllerKey.currentValue
    )
}

extension InjectedValues {
    var heroDetailView: HeroDetailView {
        get { Self[HeroDetailViewKey.self] }
        set { Self[HeroDetailViewKey.self] = newValue }
    }
}

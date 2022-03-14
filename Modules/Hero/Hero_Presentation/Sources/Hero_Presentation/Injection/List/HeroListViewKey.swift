@testable import Common
@testable import Hero_Domain
@testable import Hero_Data
@testable import UICore

struct HeroListViewKey: InjectionKey {
    typealias Value = HeroListView
    static var currentValue: HeroListView = HeroListView(
            viewModel: HeroListViewModelKey.currentValue,
            controller: HeroListControllerKey.currentValue,
            detailView: HeroDetailViewKey.currentValue
    )
}

extension InjectedValues {
    var heroListView: HeroListView {
        get { Self[HeroListViewKey.self] }
        set { Self[HeroListViewKey.self] = newValue }
    }
}

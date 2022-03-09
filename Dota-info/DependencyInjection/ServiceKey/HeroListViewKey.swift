@testable import Common
@testable import Hero_Domain
@testable import Hero_Data
@testable import Hero_Presentation
@testable import UICore

struct HeroListViewKey: InjectionKey {
    typealias Value = HeroListView
    static var currentValue: HeroListView = HeroListView(
        viewModel: HeroListViewModelKey.currentValue,
        actions: HeroListActions(
            
            requestHeroes: RequestHeroesAction(
                getHeroesUseCase: GetHeroesUseCase(
                    heroService: HeroServiceKey.currentValue,
                    loggerFactory: LoggerFactoryKey.currentValue,
                    output: HeroListViewModelKey.currentValue
                )
            ),
        
            dismissDialog: DismissDialogAction(),
            
            throwDummyError: ThrowDummyErrorAction()
            
        )
    )
}

extension InjectedValues {
    var heroListView: HeroListView {
        get { Self[HeroListViewKey.self] }
        set { Self[HeroListViewKey.self] = newValue }
    }
}

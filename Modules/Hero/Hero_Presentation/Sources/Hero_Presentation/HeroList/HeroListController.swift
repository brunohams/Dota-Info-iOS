import Foundation
@testable import Hero_Domain
@testable import UICore
@testable import Common

class HeroListController {

    private let viewModel: HeroListViewModel
    private let getHeroesUseCase: GetHeroesUseCase

    init(viewModel: HeroListViewModel, getHeroesUseCase: GetHeroesUseCase) {
        self.viewModel = viewModel
        self.getHeroesUseCase = getHeroesUseCase
    }

    func on(_ action: HeroListActions) {
        switch action {
        case .requestHeroes:
            requestHeroes()
        case .reloadHeroes:
            reloadHeroes()
        case .dismissDialog:
            viewModel.dismissDialog()
        case .increaseQuantity:
            AppStore.shared.dispatch(IncreaseErrorQuantityAction())
        }
    }

    private func requestHeroes() {
        AppStore.shared.dispatch(IncreaseErrorQuantityAction())
        getHeroesUseCase.execute()
    }

    private func reloadHeroes() {
        getHeroesUseCase.execute()
    }

}

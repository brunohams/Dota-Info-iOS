import Foundation
@testable import Hero_Domain
@testable import UICore

class HeroListController {

    private let viewModel: HeroListViewModel
    private let getHeroesUseCase: GetHeroesUseCase

    init(viewModel: HeroListViewModel, getHeroesUseCase: GetHeroesUseCase) {
        self.viewModel = viewModel
        self.getHeroesUseCase = getHeroesUseCase
    }

    func trigger(action: HeroListActions) {
        switch action {
        case .requestHeroes:
            DispatchQueue.global(qos: .background).async( execute: {
                AppStore.shared.dispatch(IncreaseErrorQuantityAction())
                self.getHeroesUseCase.execute()
            })
        case .reloadHeroes:
            DispatchQueue.global(qos: .background).async( execute: {
                self.getHeroesUseCase.execute()
            })
        case .dismissDialog:
            viewModel.dismissDialog()
        case .increaseQuantity:
            AppStore.shared.dispatch(
                IncreaseErrorQuantityAction()
            )
        }
    }

}

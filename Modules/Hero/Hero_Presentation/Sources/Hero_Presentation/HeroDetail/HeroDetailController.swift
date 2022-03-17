import Foundation
@testable import Hero_Domain
@testable import UICore

class HeroDetailController {

    private let viewModel: HeroDetailViewModel
    private let getHeroUseCase: GetHeroUseCase

    init(viewModel: HeroDetailViewModel, getHeroUseCase: GetHeroUseCase) {
        self.viewModel = viewModel
        self.getHeroUseCase = getHeroUseCase
    }

    func on(_ action: HeroDetailActions) {
        switch action {
        case .loadHero(id: let id):
            loadHero(id)
        case .dismissDialog:
            viewModel.dismissDialog()
        case .increaseQuantity:
            AppStore.shared.dispatch(IncreaseErrorQuantityAction())
        }
    }

    private func loadHero(_ id: Int) {
        AppStore.shared.dispatch(IncreaseErrorQuantityAction())

        let input = GetHeroInput(heroId: id)
        getHeroUseCase.execute(input: input)
    }

}

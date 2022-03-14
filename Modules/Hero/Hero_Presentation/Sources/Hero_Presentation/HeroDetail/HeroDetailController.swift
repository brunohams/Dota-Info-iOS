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

    func trigger(action: HeroDetailActions) {
        switch action {
        case .loadHero(id: let id):
            DispatchQueue.global(qos: .background).async(execute: {
                AppStore.shared.dispatch(IncreaseErrorQuantityAction())
                self.getHeroUseCase.execute(heroId: id)
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

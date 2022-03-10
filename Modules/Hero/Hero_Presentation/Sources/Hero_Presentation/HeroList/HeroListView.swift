import SwiftUI
@testable import UICore
@testable import Shared_Domain
@testable import Hero_Domain

struct HeroListView: View {

    @ObservedObject var viewModel: HeroListViewModel
    let getHeroesUseCase: GetHeroesUseCase
    
    @State private var showingConfirmation = true

    init(viewModel: HeroListViewModel, getHeroesUseCase: GetHeroesUseCase) {
        self.viewModel = viewModel
        self.getHeroesUseCase = getHeroesUseCase
        
        HeroStore.shared.dispatch(
            RequestHeroesAction(useCase: getHeroesUseCase)
        )
    }
    
    var body: some View {

        if viewModel.state.progressBar == .loading {
            ActivityIndicator()
        } else {
            List(viewModel.state.heroes) { hero in
                HeroRow(hero: hero)
            }
            Button("Reload again", role: .none) {
                HeroStore.shared.dispatch(
                    RequestHeroesAction(useCase: getHeroesUseCase)
                )
            }
            Button("Throw dummy error", role: .destructive) {
                HeroStore.shared.dispatch(
                    ThrowDummyErrorAction()
                )
                AppStore.shared.dispatch(
                    IncreaseErrorQuantityAction()
                )
            }
        }

        if let dialog = viewModel.state.dialog as? UIComponent.Dialog {
            Text("")
                .alert(dialog.title, isPresented: $showingConfirmation) {
                    Button("Ok", role: .none) {
                        HeroStore.shared.dispatch(
                            DismissDialogAction()
                        )
                        showingConfirmation = true
                    }
                } message: {
                    Text(dialog.description)
                }
        }

    }
}

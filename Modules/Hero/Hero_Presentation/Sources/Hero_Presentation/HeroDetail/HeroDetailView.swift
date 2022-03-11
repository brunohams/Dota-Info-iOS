import SwiftUI
@testable import UICore
@testable import Shared_Domain
@testable import Hero_Domain

struct HeroDetailView: View {

    @ObservedObject var viewModel: HeroDetailViewModel
    let getHeroUseCase: GetHeroUseCase

    @State private var showingConfirmation = true

    init(viewModel: HeroDetailViewModel, getHeroUseCase: GetHeroUseCase) {
        self.viewModel = viewModel
        self.getHeroUseCase = getHeroUseCase


    }

    var body: some View {

        VStack {
            if viewModel.state.progressBar == .loading {
                ActivityIndicator()
            } else {
                VStack {
                    Text("id: \(viewModel.state.heroId)")
                    Text("name: \(viewModel.state.heroName)")
                    Text("url: \(viewModel.state.heroImg)")
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
        }.onAppear {
            DispatchQueue.global(qos: .background).async( execute: {
                getHeroUseCase.execute()
            })
        }

    }
}

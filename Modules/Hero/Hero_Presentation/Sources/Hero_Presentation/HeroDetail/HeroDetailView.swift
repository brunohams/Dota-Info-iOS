import SwiftUI
@testable import UICore
@testable import Shared_Domain
@testable import Hero_Domain

struct HeroDetailView: View {

    @Injected(\.heroDetailController) private var controller: HeroDetailController
    @ObservedObject private var viewModel: HeroDetailViewModel

    private let heroId: Int
    @State private var showingConfirmation = true

    init(heroId: Int) {
        @Injected(\.heroDetailViewModel) var _injectedViewModel: HeroDetailViewModel
        self.viewModel = _injectedViewModel
        self.heroId = heroId
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
                                controller.on(.dismissDialog)
                                showingConfirmation = true
                            }
                        } message: {
                            Text(dialog.description)
                        }
            }
        }.onAppear {
            controller.on(.loadHero(id: heroId))
        }

    }
}

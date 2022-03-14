import SwiftUI
@testable import UICore
@testable import Shared_Domain
@testable import Hero_Domain

struct HeroDetailView: View {

    @ObservedObject var viewModel: HeroDetailViewModel
    private let controller: HeroDetailController

    @State private var showingConfirmation = true

    init(viewModel: HeroDetailViewModel,
         controller: HeroDetailController) {
        self.viewModel = viewModel
        self.controller = controller
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
                                controller.trigger(action: .dismissDialog)
                                showingConfirmation = true
                            }
                        } message: {
                            Text(dialog.description)
                        }
            }
        }.onAppear {
            controller.trigger(action: .loadHero(id: 3))
        }

    }
}

import SwiftUI
@testable import UICore
@testable import Shared_Domain
@testable import Hero_Domain

struct HeroListView: View {

    @ObservedObject var viewModel: HeroListViewModel
    private let controller: HeroListController

    let detailView: HeroDetailView

    @State private var showingConfirmation = true

    init(viewModel: HeroListViewModel, controller: HeroListController, detailView: HeroDetailView) {
        self.viewModel = viewModel
        self.controller = controller
        self.detailView = detailView

        controller.on(.requestHeroes)
    }
    
    var body: some View {

        if viewModel.state.progressBar == .loading {
            ActivityIndicator()
        } else {
            NavigationView {
                List(viewModel.state.heroes) { hero in
                    NavigationLink(destination: detailView) {
                        HeroRow(hero: hero)
                    }.navigationViewStyle(StackNavigationViewStyle())
                }.navigationBarTitle("List of Heroes")
            }
            Button("Reload again", role: .none) {
                controller.on(.reloadHeroes)
            }
            Button("Increase Quantity", role: .destructive) {
                controller.on(.increaseQuantity)
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

    }

}

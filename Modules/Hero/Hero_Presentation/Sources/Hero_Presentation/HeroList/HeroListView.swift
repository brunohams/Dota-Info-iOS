import SwiftUI
@testable import UICore
@testable import Shared_Domain
@testable import Hero_Domain

struct HeroListView: View {

    @ObservedObject var viewModel: HeroListViewModel
    @Injected(\.heroListController) private var controller: HeroListController

    @State private var showingConfirmation = true

    init() {
        @Injected(\.heroListViewModel) var _injectedViewModel: HeroListViewModel
        self.viewModel = _injectedViewModel
    }
    
    var body: some View {

        VStack {

            if viewModel.state.progressBar == .loading {
                ActivityIndicator()
            } else {
                NavigationView {
                    List(viewModel.state.heroes) { hero in
                        NavigationLink(destination: HeroDetailView(heroId: hero.id)) {
                            HeroRow(hero: hero)
                        }.navigationViewStyle(StackNavigationViewStyle())
                    }.navigationBarTitle("List of Heroes")
                }
                Button("Reload again", role: .none) {
                    Task.detached {
                        await controller.on(.reloadHeroes)
                    }
                }
                Button("Increase Quantity", role: .destructive) {
                    Task.detached {
                        await controller.on(.increaseQuantity)
                    }
                }
            }

            if let dialog = viewModel.state.dialog as? UIComponent.Dialog {
                Text("")
                        .alert(dialog.title, isPresented: $showingConfirmation) {
                            Button("Ok", role: .none) {
                                Task.detached {
                                    await controller.on(.dismissDialog)
                                }
                                showingConfirmation = true
                            }
                        } message: {
                            Text(dialog.description)
                        }
            }

        }.onAppear {
            Task.detached {
                await controller.on(.requestHeroes)
            }
        }

    }

}

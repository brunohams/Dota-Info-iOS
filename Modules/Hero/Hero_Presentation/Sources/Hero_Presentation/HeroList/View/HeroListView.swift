import SwiftUI
@testable import UICore
@testable import Shared_Domain
@testable import Hero_Domain

struct HeroListView: View {

    @ObservedObject var viewModel: HeroListViewModel
    let actions: HeroListActions
    
    @State private var showingConfirmation = true

    init(viewModel: HeroListViewModel, actions: HeroListActions) {
        self.viewModel = viewModel
        self.actions = actions
        
        store.dispatch(actions.requestHeroes)
    }
    
    var body: some View {

        if viewModel.state.progressBar == .loading {
            ActivityIndicator()
        } else {
            List(viewModel.state.heroes) { hero in
                HeroRow(hero: hero)
            }
            Button("Reload again", role: .none) {
                store.dispatch(actions.requestHeroes)
            }
            Button("Throw dummy error", role: .destructive) {
                store.dispatch(actions.throwDummyError)
            }
        }

        if let dialog = viewModel.state.dialog as? UIComponent.Dialog {
            Text("")
                .alert(dialog.title, isPresented: $showingConfirmation) {
                    Button("Ok", role: .none) {
                        store.dispatch(actions.dismissDialog)
                        showingConfirmation = true
                    }
                } message: {
                    Text(dialog.description)
                }
        }

    }
}

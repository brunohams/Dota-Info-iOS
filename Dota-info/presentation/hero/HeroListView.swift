import SwiftUI

struct HeroListView: View {

    @StateObject var viewModel: HeroListViewModel
    @State private var showingConfirmation = true

    var body: some View {

        List(viewModel.state.heroes) { hero in
            HeroRow(hero: hero)
        }

        if viewModel.state.progressBar == .loading {
            ActivityIndicator()
        }

        if let dialog = viewModel.state.dialog as? UIComponent.Dialog {
            Text("")
                .alert(dialog.title, isPresented: $showingConfirmation) {
                    Button("Ok", role: .cancel) { }
                } message: {
                    Text(dialog.description)
                }
        }

    }
}

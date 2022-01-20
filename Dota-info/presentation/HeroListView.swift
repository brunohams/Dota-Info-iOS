import SwiftUI

struct HeroListView: View {
    @ObservedObject var viewModel: HeroListViewModel

    var body: some View {

        switch viewModel.state.progressBar {
            case .loading:
                Text("Loading")
            case .idle:
                Text("Idle")
        }

    }
}

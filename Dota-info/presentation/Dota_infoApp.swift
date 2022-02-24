import SwiftUI
@testable import Core
@testable import DataSource

@main
struct Dota_infoApp: App {

    @Injected(\.heroListViewModel) var heroListViewModel: HeroListViewModel


    var body: some Scene {
        WindowGroup {
            HeroListView(viewModel: heroListViewModel)
        }
    }
}

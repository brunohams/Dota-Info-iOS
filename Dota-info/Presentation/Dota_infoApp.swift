import SwiftUI
@testable import Common
@testable import Hero_Presentation

@main
struct Dota_infoApp: App {

    @Injected(\.heroListViewModel) var heroListViewModel: HeroListViewModel


    var body: some Scene {
        WindowGroup {
            HeroListView(viewModel: heroListViewModel)
        }
    }
}

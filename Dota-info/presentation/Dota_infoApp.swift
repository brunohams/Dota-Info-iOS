import SwiftUI

@main
struct Dota_infoApp: App {

    // Inject these
    var heroListViewModel: HeroListViewModel

    init() {
        // Inject these
        let heroService = HeroServiceImpl()
        let getHeroes = GetHeroes(heroService: HeroServiceImpl())
        let logger = Logger.createDebugLogger(tag: "HeroList")
        heroListViewModel = HeroListViewModel(getHeroes: getHeroes, logger: logger)
    }

    var body: some Scene {
        WindowGroup {
            HeroListView(viewModel: heroListViewModel)
        }
    }
}

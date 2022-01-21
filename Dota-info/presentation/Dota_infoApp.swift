import SwiftUI

@main
struct Dota_infoApp: App {

    // Inject these
    private var heroListViewModel: HeroListViewModel

    init() {
        // Inject these
        let heroService = HeroServiceFake.init(responseType: .goodData)
        let getHeroes = GetHeroes(heroService: heroService)
        let logger = Logger.createDebugLogger(tag: "HeroList")
        heroListViewModel = HeroListViewModel(getHeroes: getHeroes, logger: logger)
    }

    var body: some Scene {
        WindowGroup {
            HeroListView(viewModel: heroListViewModel)
        }
    }
}

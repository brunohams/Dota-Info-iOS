import SwiftUI

@main
struct Dota_infoApp: App {

    // Inject these
    private var heroListViewModel: HeroListViewModel

    init() {
        // Inject these
        let heroService = HeroServiceImpl.init()
        let heroListLogger = Logger.createDebugLogger(tag: "HeroList")
        let getHeroesLogger = Logger.createDebugLogger(tag: "GetHeroes")
        let getHeroes = GetHeroes(heroService: heroService, logger: getHeroesLogger)
        heroListViewModel = HeroListViewModel(getHeroes: getHeroes, logger: heroListLogger)
    }

    var body: some Scene {
        WindowGroup {
            HeroListView(viewModel: heroListViewModel)
        }
    }
}

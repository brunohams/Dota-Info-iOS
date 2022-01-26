import SwiftUI

@main
struct Dota_infoApp: App {

    // Inject these
    private var heroListViewModel: HeroListViewModel

    init() {
        // Inject these
        let heroService = HeroServiceFake.init(responseType: .goodData)
        let loggerFactory = LoggerDebugFactory()

        let getHeroes = GetHeroes(heroService: heroService, loggerFactory: loggerFactory)
        heroListViewModel = HeroListViewModel(getHeroes: getHeroes, loggerFactory: loggerFactory)
    }

    var body: some Scene {
        WindowGroup {
            HeroListView(viewModel: heroListViewModel)
        }
    }
}

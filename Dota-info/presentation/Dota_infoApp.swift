import SwiftUI

@main
struct Dota_infoApp: App {

    // Inject these
    private var heroListViewModel: HeroListViewModel

    init() {
        // Inject these
        let heroService = HeroServiceFake.init(responseType: .emptyList)
        let loggerFactory = LoggerDebugFactory()

        let getHeroes = GetHeroes(heroService: heroService, logger: loggerFactory)
        heroListViewModel = HeroListViewModel(getHeroes: getHeroes, logger: loggerFactory)
    }

    var body: some Scene {
        WindowGroup {
            HeroListView(viewModel: heroListViewModel)
        }
    }
}

import SwiftUI
@testable import UICore
@testable import Hero_Domain
@testable import Hero_Presentation

@main
struct Dota_infoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Injected(\.heroListView) var heroListView: HeroListView

    var body: some Scene {
        WindowGroup {
            VStack {
                AppHeaderView(viewModel: AppHeaderViewModel())
                heroListView
            }
        }
    }
}

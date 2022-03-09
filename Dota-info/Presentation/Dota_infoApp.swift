import SwiftUI
@testable import Common
@testable import Hero_Domain
@testable import Hero_Presentation

@main
struct Dota_infoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @Injected(\.heroListView) var heroListView: HeroListView

    var body: some Scene {
        WindowGroup {
            heroListView
        }
    }
}

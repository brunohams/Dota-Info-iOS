import SwiftUI
@testable import Hero_Domain

struct HeroRow: View {
    var hero: Hero
    let floatVersion = (UIDevice.current.systemVersion as NSString).floatValue

    var body: some View {
        Text(hero.localizedName)
    }
}

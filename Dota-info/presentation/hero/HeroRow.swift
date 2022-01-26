import SwiftUI
@testable import Hero

struct HeroRow: View {
    var hero: Hero

    var body: some View {
        Text(hero.localizedName)
    }
}

import SwiftUI
@testable import Domain

struct HeroRow: View {
    var hero: Hero

    var body: some View {
        Text(hero.localizedName)
    }
}

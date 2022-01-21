import SwiftUI

struct HeroRow: View {
    var hero: Hero

    var body: some View {
        Text(hero.localizedName)
    }
}
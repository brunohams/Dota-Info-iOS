import SwiftUI
@testable import UICore
@testable import Shared_Domain
@testable import Hero_Domain

struct AppHeaderView: View {

    @ObservedObject var viewModel: AppHeaderViewModel

    var body: some View {

        Text("Total of Errors: \(viewModel.state.numberOfErrors)")

    }
}

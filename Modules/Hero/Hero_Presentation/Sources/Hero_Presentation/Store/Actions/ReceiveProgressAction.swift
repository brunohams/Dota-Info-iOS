import Foundation
import ReSwift
@testable import Shared_Domain

struct ReceiveProgressAction: Action {
    let tag = "receive_progress"
    let progress: ProgressState
}
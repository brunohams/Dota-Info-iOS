import Foundation
import ReSwift
@testable import Shared_Domain

struct ReceiveErrorAction: Action {
    let tag = "receive_error"
    let error: ErrorDetail
}
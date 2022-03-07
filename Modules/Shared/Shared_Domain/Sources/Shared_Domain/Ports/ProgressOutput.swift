import Foundation

protocol ProgressOutput {
    func didGetProgress(progress: ProgressState)
}

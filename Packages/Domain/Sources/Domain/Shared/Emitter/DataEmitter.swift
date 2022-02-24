import Foundation

class DataEmitter<T> {
    
    func emit(_: T) {
        preconditionFailure("This method must be overridden")
    }
    func finish() {
        preconditionFailure("This method must be overridden")
    }
    
}

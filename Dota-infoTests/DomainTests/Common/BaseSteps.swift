import Foundation
import Cucumberish

class BaseSteps: XCTest {
    let argument = "\"([A-Za-z0-9._%+-@]+)\""
    
    func execute() {
        preconditionFailure("This method must be overridden")
    }
}

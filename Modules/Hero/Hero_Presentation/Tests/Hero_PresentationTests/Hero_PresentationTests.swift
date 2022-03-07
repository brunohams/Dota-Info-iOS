import XCTest
@testable import Hero_Domain
@testable import Hero_Data
@testable import UICore
@testable import Common

@testable import Shared_Domain
@testable import Hero_Presentation

final class Hero_PresentationTests: XCTestCase {
    func testExample() throws {
        
        
        let loggerFactory = LoggerDebugFactory()
        var heroService = HeroServiceFake(responseType: .goodData)
        var getHeroes = GetHeroes(heroService: heroService, loggerFactory: loggerFactory)
        
        let viewModel = HeroListViewModel(getHeroes: getHeroes, loggerFactory: loggerFactory)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // Change `2.0` to the desired number of seconds.
            print("vm = \(viewModel.state.heroes)")
        }
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual("Hello, World!", "Hello, World!")
    }
}

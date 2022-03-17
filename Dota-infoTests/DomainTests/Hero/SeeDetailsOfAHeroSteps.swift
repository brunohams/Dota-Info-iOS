import Foundation
import Cucumberish
import XCTest
import RxBlocking
import RxSwift
@testable import Hero_Domain
@testable import Hero_Data
@testable import Hero_Presentation
@testable import Common
@testable import Shared_Domain

class SeeDetailsOfHeroSteps: BaseSteps {

    override func execute() {

        Given("the user has loaded a list of heroes") { _,_ in
            // User asking in UI
            XCTAssert(true)
        }

        When("he selects the hero \(argument)") { args, _ in
        }

        Then("should load the name, id and image url of the hero") { _, _ in

        }

        XCTAssert(true)

    }


    private func createController(_ viewModel: HeroListViewModel, _ service: HeroService) -> HeroListController {
        return HeroListController(
                viewModel: viewModel,
                getHeroesUseCase: GetHeroesUseCase(
                        heroService: service,
                        loggerFactory: LoggerDebugFactory.init(),
                        output: viewModel
                )
        )
    }

}

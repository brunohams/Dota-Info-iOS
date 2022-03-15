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

class FetchHeroesSteps: BaseSteps {

    override func execute() {
        var apiResponse: String? = nil
        var controller: HeroListController? = nil
        let viewModel = HeroListViewModel()

        Given("the user ask for a list of heroes") { _,_ in
            // User asking in UI
        }

        When("API responds with \(argument)") { args, _ in
            apiResponse = args!.first!

            switch apiResponse {
                case "error":
                    controller = self.createController(viewModel, HeroServiceFake(responseType: .malformed))
                case "no_content":
                    controller = self.createController(viewModel, HeroServiceFake(responseType: .emptyList))
                case "success":
                    controller = self.createController(viewModel, HeroServiceFake(responseType: .goodData))
                default:
                    fatalError("Unexpected Response")
            }

        }

        Then("result should be \(argument)") { args, _ in

            do {

                controller!.on(.requestHeroes)

                let dialog = viewModel.state.dialog
                let progress = viewModel.state.progressBar
                let heroes = viewModel.state.heroes

                switch apiResponse {
                case "error":
                    XCTAssert(dialog is UIComponent.Dialog, "Dialog should be Error Dialog")
                    XCTAssertEqual((dialog as? UIComponent.Dialog)?.title, "Erro ao retornar lista de herois.")
                    XCTAssert(progress == .idle, "Progress should be idle")
                    XCTAssert(heroes.isEmpty, "Heroes should be Empty")

                case "no_content":
                    XCTAssert(dialog is UIComponent.None, "Dialog should be None")
                    XCTAssert(progress == .idle, "Progress should be idle")
                    XCTAssert(heroes.isEmpty, "Heroes should be Empty")

                case "success":
                    XCTAssert(dialog is UIComponent.None, "Dialog should be None")
                    XCTAssert(progress == .idle, "Progress should be idle")
                    XCTAssert(heroes.isEmpty == false, "Heroes should not be Empty")
                    XCTAssert(heroes.count > 0, "Heroes should be on list")

                default:
                    fatalError("Unexpected Response")
                }

            } catch {
                XCTFail("Fail to ask for list of heroes")
            }

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

    private func delayIn(seconds: Double) {
        let timeout = seconds * 2
        let expectation = XCTestExpectation(description: "Wait for async work")
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) { expectation.fulfill() }
        XCTWaiter.wait(for: [expectation], timeout: timeout)
    }

}

import Foundation
import Cucumberish
import XCTest
import RxBlocking
@testable import Domain
@testable import DataSource
@testable import Core

class FetchHeroesSteps: BaseSteps {

    override func execute() {
        
        let loggerFactory = LoggerDebugFactory()
        var heroService = HeroServiceFake(responseType: .malformed)
        var useCase = GetHeroes(heroService: heroService, loggerFactory: loggerFactory)

        var listOfHeroes: [Hero]? = nil
        var apiResponse: String? = nil
        
        Given("the user ask for a list of heroes") { _,_ in            
            // User asking in UI
        }
        
        When("API responds with \(argument)") { args, _ in
            
            apiResponse = args!.first!
            
            switch apiResponse {
                case "error":
                    heroService = HeroServiceFake(responseType: .malformed)
                case "no_content":
                    heroService = HeroServiceFake(responseType: .emptyList)
                case "success":
                    heroService = HeroServiceFake(responseType: .goodData)
                default:
                    fatalError("Unexpected Response")
            }
            
            
        }
        
        Then("result should be \(argument)") {_, _ in
            
            do {
                
                useCase = GetHeroes(heroService: heroService, loggerFactory: loggerFactory)
                
                // Execute USE Case
                let emissions = try useCase.execute()
                    .toBlocking(timeout: 3)
                    .toArray()
                
                switch apiResponse {
                    case "error":
                    
                        // Assert that the second emission should be ERROR
                        if case let .response(uiComponent) = emissions[1] {
                           XCTAssertNotNil(uiComponent) // Is not nil
                           XCTAssert(uiComponent is UIComponent.Dialog)
                           XCTAssertEqual((uiComponent as? UIComponent.Dialog)?.title, "Erro de rede")
                        } else {
                            XCTFail("Emission not the expected type")
                        }
                    
                    case "no_content":
                    
                        // Assert that the second emission should be Data
                        if case let .data(data) = emissions[1] {
                            listOfHeroes = data
                            XCTAssertNotNil(data) // Is not nil
                            XCTAssertEqual(data!.count, 0) // has no values
                        } else {
                            XCTFail("Emission not the expected type")
                        }
                    
                    case "success":
                    
                        // Assert that the second emission should be Data
                        if case let .data(data) = emissions[1] {
                            listOfHeroes = data
                            XCTAssertNotNil(data) // Is not nil
                            XCTAssertGreaterThan(data!.count, 0) // has values
                        } else {
                            XCTFail("Emission not the expected type")
                        }
                    
                    default:
                        fatalError("Unexpected Response")
                }

                
            } catch {
                XCTFail("Fail to ask for list of heroes")
            }
            
            XCTAssert(true)
        }
        
    }
}

import XCTest
import RxBlocking
@testable import Domain
@testable import DataSource
@testable import Core

class GetHeroesTest: XCTestCase {
    
    func test_Given_GoodData_Should_ReturnListOfHeroes() throws {
        
        let heroService = HeroServiceFake(responseType: .goodData)
        let loggerFactory = LoggerDebugFactory()
        let useCase = GetHeroes(heroService: heroService, loggerFactory: loggerFactory)
        
        // Execute USE Case
        let emissions = try useCase.execute()
            .toBlocking(timeout: 3)
            .toArray()
        
        // Assert that in are 3 emissions in this scenario
        XCTAssertEqual(emissions.count, 3)
        
        // Assert that the first emit should be LOADING
        if case let .progress(progressState) = emissions[0] {
            XCTAssert(progressState == ProgressState.loading)
        } else {
            XCTFail("Emission not the expected type")
        }
        
        // Assert that the second emission should be DATA
        if case let .data(data) = emissions[1] {
            XCTAssertNotNil(data) // Is not nil
            XCTAssertGreaterThan(data!.count, 0) // has values
        } else {
            XCTFail("Emission not the expected type")
        }
        
        // Assert that the third emission should be IDLE
        if case let .progress(progressState) = emissions[2] {
            XCTAssert(progressState == ProgressState.idle)
        } else {
            XCTFail("Emission not the expected type")
        }

    }
    
    func test_Given_EmptyData_Should_ReturnEmptyList() throws {

        let service = HeroServiceFake.init(responseType: HeroServiceResponseType.emptyList)
        let loggerFactory = LoggerDebugFactory()
        let useCase = GetHeroes(heroService: service, loggerFactory: loggerFactory)

        // Execute USE Case
        let emissions = try useCase.execute()
            .toBlocking(timeout: 3)
            .toArray()

        // Assert that in are 3 emissions in this scenario
        XCTAssertEqual(emissions.count, 3)

        // Assert that the first emit should be LOADING
        if case let .progress(progressState) = emissions[0] {
           XCTAssert(progressState == ProgressState.loading)
        } else {
            XCTFail("Emission not the expected type")
        }

        // Assert that the second emission should be DATA
        if case let .data(data) = emissions[1] {
           XCTAssertNotNil(data) // Is not nil
           XCTAssertEqual(data!.count, 0) // has values
        } else {
            XCTFail("Emission not the expected type")
        }

        // Assert that the third emission should be IDLE
        if case let .progress(progressState) = emissions[2] {
           XCTAssert(progressState == ProgressState.idle)
        } else {
            XCTFail("Emission not the expected type")
        }

   }
    

    func test_Given_CorruptedData_Should_ReturnError() throws {

        let service = HeroServiceFake.init(responseType: HeroServiceResponseType.malformed)
        let loggerFactory = LoggerDebugFactory()
        let useCase = GetHeroes(heroService: service, loggerFactory: loggerFactory)

        // Execute USE Case
        let emissions = try useCase.execute()
            .toBlocking(timeout: 3)
            .toArray()

        // Assert that in are 3 emissions in this scenario
        XCTAssertEqual(emissions.count, 3)

        // Assert that the first emit should be LOADING
        if case let .progress(progressState) = emissions[0] {
           XCTAssert(progressState == ProgressState.loading)
        } else {
            XCTFail("Emission not the expected type")
        }

        // Assert that the second emission should be ERROR
        if case let .response(uiComponent) = emissions[1] {
           XCTAssertNotNil(uiComponent) // Is not nil
           XCTAssert(uiComponent is UIComponent.Dialog)
           XCTAssertEqual((uiComponent as? UIComponent.Dialog)?.title, "Erro de rede")
        } else {
            XCTFail("Emission not the expected type")
        }

        // Assert that the third emission should be IDLE
        if case let .progress(progressState) = emissions[2] {
           XCTAssert(progressState == ProgressState.idle)
        } else {
            XCTFail("Emission not the expected type")
        }

    }
    
}

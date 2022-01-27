import XCTest
import Combine
@testable import DataSource
@testable import Core
@testable import Interactors
@testable import Domain

class GetHeroesTests: XCTestCase {

    let loggerFactory = LoggerDebugFactory()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWhenValidDataShouldReturnSuccess() throws {
        // GIVEN
        let service = HeroServiceFake.init(responseType: HeroServiceResponseType.goodData)
        let getHeroes = GetHeroes(heroService: service, loggerFactory: loggerFactory)
        var emissions: [DataState<[Hero]>] = []
        let receivedAllValues = expectation(description: "all values emitted")

        // WHEN
        getHeroes.subject
                .subscribe(on: DispatchQueue.global(qos: .default))
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    receivedAllValues.fulfill()
                }, receiveValue: { states in
                    emissions.append(states)
                })
        getHeroes.execute()
        waitForExpectations(timeout: 5)

        // THEN
        // Assert that in are 3 emissions in this scenario
        XCTAssertEqual(emissions.count, 3)

        // Assert that the first emit should be LOADING
        if case let .loading(progressState) = emissions[0] {
            XCTAssert(progressState == ProgressState.loading)
        } else {
            XCTAssert(false, "Emission not the right type")
        }

        // Assert that the second emission should be DATA
        if case let .data(data) = emissions[1] {
            XCTAssertNotNil(data) // Is not nil
            XCTAssertGreaterThan(data!.count, 0) // has values
        } else {
            XCTAssert(false, "Emission not the right type")
        }

        // Assert that the third emission should be IDLE
        if case let .loading(progressState) = emissions[2] {
            XCTAssert(progressState == ProgressState.idle)
        } else {
            XCTAssert(false, "Emission not the right type")
        }

    }

    func testWhenEmptyDataShouldReturnSuccessWithEmptyList() throws {

        let service = HeroServiceFake.init(responseType: HeroServiceResponseType.emptyList)
        let getHeroes = GetHeroes(heroService: service, loggerFactory: loggerFactory)
        var emissions: [DataState<[Hero]>] = []
        let receivedAllValues = expectation(description: "all values emitted")

        // WHEN
        getHeroes.subject
                .eraseToAnyPublisher()
                .subscribe(on: DispatchQueue.main)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    receivedAllValues.fulfill()
                }, receiveValue: { states in
                    emissions.append(states)
                })
        getHeroes.execute()
        waitForExpectations(timeout: 5)

        // Assert that in are 3 emissions in this scenario
        XCTAssertEqual(emissions.count, 3)

        // Assert that the first emit should be LOADING
        if case let .loading(progressState) = emissions[0] {
            XCTAssert(progressState == ProgressState.loading)
        } else {
            XCTAssert(false, "Emission not the right type")
        }

        // Assert that the second emission should be DATA
        if case let .data(data) = emissions[1] {
            XCTAssertNotNil(data) // Is not nil
            XCTAssertEqual(data!.count, 0) // has values
        } else {
            XCTAssert(false, "Emission not the right type")
        }

        // Assert that the third emission should be IDLE
        if case let .loading(progressState) = emissions[2] {
            XCTAssert(progressState == ProgressState.idle)
        } else {
            XCTAssert(false, "Emission not the right type")
        }

    }

    func testWhenCorruptedJsonDataShouldReturnError() throws {

        let service = HeroServiceFake.init(responseType: HeroServiceResponseType.malformed)
        let getHeroes = GetHeroes(heroService: service, loggerFactory: loggerFactory)
        var emissions: [DataState<[Hero]>] = []
        let receivedAllValues = expectation(description: "all values emitted")

        // WHEN
        getHeroes.subject
                .subscribe(on: DispatchQueue.global(qos: .default))
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    receivedAllValues.fulfill()
                }, receiveValue: { states in
                    emissions.append(states)
                })
        getHeroes.execute()
        waitForExpectations(timeout: 5)

        // Assert that in are 3 emissions in this scenario
        XCTAssertEqual(emissions.count, 3)

        // Assert that the first emit should be LOADING
        if case let .loading(progressState) = emissions[0] {
            XCTAssert(progressState == ProgressState.loading)
        } else {
            XCTAssert(false, "Emission not the right type")
        }

        // Assert that the second emission should be ERROR
        if case let .response(uiComponent) = emissions[1] {
            XCTAssertNotNil(uiComponent) // Is not nil
            XCTAssert(uiComponent is UIComponent.Dialog)
            XCTAssertEqual((uiComponent as? UIComponent.Dialog)?.title, "Erro de rede")
        } else {
            XCTAssert(false, "Emission not the right type")
        }

        // Assert that the third emission should be IDLE
        if case let .loading(progressState) = emissions[2] {
            XCTAssert(progressState == ProgressState.idle)
        } else {
            XCTAssert(false, "Emission not the right type")
        }

    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

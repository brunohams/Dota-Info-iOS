import XCTest
import Combine

class GetHeroesTests: XCTestCase {

    let logger = Logger.createDebugLogger(tag: "GetHeroesTests")

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWhenValidDataShouldReturnSuccess() throws {
        // GIVEN
        let service = HeroServiceFake.init(responseType: HeroServiceResponseType.goodData)
        let getHeroes = GetHeroes(heroService: service, logger: logger)
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
        switch (emissions[0]) {
            case .loading(progressState: let progressState):
                XCTAssert(progressState == ProgressState.loading)
            default:
                XCTAssert(false, "Emission not the right type")
        }

        // Assert that the second emission should be DATA
        switch (emissions[1]) {
            case .data(data: let data):
                XCTAssertNotNil(data) // Is not nil
                XCTAssertGreaterThan(data!.count, 0) // has values
            default:
                XCTAssert(false, "Emission not the right type")
        }

        // Assert that the third emission should be IDLE
        switch (emissions[2]) {
            case .loading(progressState: let progressState):
                XCTAssert(progressState == ProgressState.idle)
            default:
                XCTAssert(false, "Emission not the right type")
        }

    }

    func testWhenEmptyDataShouldReturnSuccessWithEmptyList() throws {

        let service = HeroServiceFake.init(responseType: HeroServiceResponseType.emptyList)
        let getHeroes = GetHeroes(heroService: service, logger: logger)
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
        switch (emissions[0]) {
        case .loading(progressState: let progressState):
            XCTAssert(progressState == ProgressState.loading)
        default:
            XCTAssert(false, "Emission not the right type")
        }

        // Assert that the second emission should be DATA
        switch (emissions[1]) {
        case .data(data: let data):
            XCTAssertNotNil(data) // Is not nil
            XCTAssertEqual(data!.count, 0) // has values
        default:
            XCTAssert(false, "Emission not the right type")
        }

        // Assert that the third emission should be IDLE
        switch (emissions[2]) {
        case .loading(progressState: let progressState):
            XCTAssert(progressState == ProgressState.idle)
        default:
            XCTAssert(false, "Emission not the right type")
        }

    }

    func testWhenCorruptedJsonDataShouldReturnError() throws {

        let service = HeroServiceFake.init(responseType: HeroServiceResponseType.malformed)
        let getHeroes = GetHeroes(heroService: service, logger: logger)
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
        switch (emissions[0]) {
        case .loading(progressState: let progressState):
            XCTAssert(progressState == ProgressState.loading)
        default:
            XCTAssert(false, "Emission not the right type")
        }

        // Assert that the second emission should be ERROR
        switch (emissions[1]) {
        case .response(uiComponent: let uiComponent):
            XCTAssertNotNil(uiComponent) // Is not nil
            XCTAssert(uiComponent is UIComponent.Dialog)
            XCTAssertEqual((uiComponent as? UIComponent.Dialog)?.title, "Erro de rede")
        default:
            XCTAssert(false, "Emission not the right type")
        }

        // Assert that the third emission should be IDLE
        switch (emissions[2]) {
        case .loading(progressState: let progressState):
            XCTAssert(progressState == ProgressState.idle)
        default:
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

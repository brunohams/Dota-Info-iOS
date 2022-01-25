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

        let service = HeroServiceFake.init(responseType: HeroServiceResponseType.goodData)
        let getHeroes = GetHeroes(heroService: service, logger: logger)

        let emissions = try awaitPublisher(getHeroes.subject)
        getHeroes.execute()

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

//    func testWhenEmptyDataShouldReturnSuccessWithEmptyList() throws {
//
//        let service = HeroServiceFake.init(responseType: HeroServiceResponseType.emptyList)
//        let getHeroes = GetHeroes(heroService: service, logger: logger)
//
//        let emissions = try getHeroes.execute()
//                .toBlocking()
//                .toArray()
//
//        // Assert that in are 3 emissions in this scenario
//        XCTAssertEqual(emissions.count, 3)
//
//        // Assert that the first emit should be LOADING
//        switch (emissions[0]) {
//        case .loading(progressState: let progressState):
//            XCTAssert(progressState == ProgressState.loading)
//        default:
//            XCTAssert(false, "Emission not the right type")
//        }
//
//        // Assert that the second emission should be DATA
//        switch (emissions[1]) {
//        case .data(data: let data):
//            XCTAssertNotNil(data) // Is not nil
//            XCTAssertEqual(data!.count, 0) // has values
//        default:
//            XCTAssert(false, "Emission not the right type")
//        }
//
//        // Assert that the third emission should be IDLE
//        switch (emissions[2]) {
//        case .loading(progressState: let progressState):
//            XCTAssert(progressState == ProgressState.idle)
//        default:
//            XCTAssert(false, "Emission not the right type")
//        }
//
//    }
//
//    func testWhenCorruptedJsonDataShouldReturnError() throws {
//
//        let service = HeroServiceFake.init(responseType: HeroServiceResponseType.malformed)
//        let getHeroes = GetHeroes(heroService: service, logger: logger)
//
//        let emissions = try getHeroes.execute()
//                .toBlocking()
//                .toArray()
//
//        // Assert that in are 3 emissions in this scenario
//        XCTAssertEqual(emissions.count, 3)
//
//        // Assert that the first emit should be LOADING
//        switch (emissions[0]) {
//        case .loading(progressState: let progressState):
//            XCTAssert(progressState == ProgressState.loading)
//        default:
//            XCTAssert(false, "Emission not the right type")
//        }
//
//        // Assert that the second emission should be ERROR
//        switch (emissions[1]) {
//        case .response(uiComponent: let uiComponent):
//            XCTAssertNotNil(uiComponent) // Is not nil
//            XCTAssert(uiComponent is UIComponent.Dialog)
//            XCTAssertEqual((uiComponent as? UIComponent.Dialog)?.title, "Erro ao converter dados")
//        default:
//            XCTAssert(false, "Emission not the right type")
//        }
//
//        // Assert that the third emission should be IDLE
//        switch (emissions[2]) {
//        case .loading(progressState: let progressState):
//            XCTAssert(progressState == ProgressState.idle)
//        default:
//            XCTAssert(false, "Emission not the right type")
//        }
//
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}

extension XCTestCase {

    func awaitPublisher<T: Publisher>(
            _ publisher: T,
            timeout: TimeInterval = 10,
            file: StaticString = #file,
            line: UInt = #line
    ) throws -> T.Output {
        // This time, we use Swift's Result type to keep track
        // of the result of our Combine pipeline:
        var result: Result<T.Output, Error>?
        let expectation = self.expectation(description: "Awaiting publisher")

        let cancellable = publisher.sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        result = .failure(error)
                    case .finished:
                        break
                    }

                    expectation.fulfill()
                },
                receiveValue: { value in
                    result = .success(value)
                }
        )

        // Just like before, we await the expectation that we
        // created at the top of our test, and once done, we
        // also cancel our cancellable to avoid getting any
        // unused variable warnings:
        waitForExpectations(timeout: timeout)
        cancellable.cancel()

        // Here we pass the original file and line number that
        // our utility was called at, to tell XCTest to report
        // any encountered errors at that original call site:
        let unwrappedResult = try XCTUnwrap(
                result,
                "Awaited publisher did not produce any output",
                file: file,
                line: line
        )

        return try unwrappedResult.get()
    }

}

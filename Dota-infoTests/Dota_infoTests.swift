//
//  Dota_infoTests.swift
//  Dota-infoTests
//
//  Created by PremierSoft on 20/01/22.
//

import XCTest
@testable import Dota_info

class Dota_infoTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let service = HeroServiceImpl()
        let getHeroes = GetHeroes(heroService: service)

        getHeroes.execute().subscribe { event in

            guard let state: DataState<[Hero]> = event.element else { return }

            switch (state) {
                case .response(uiComponent: let uiComponent):
                    print("Response: \(uiComponent)")
                case .data(data: let data):
                    print("Data: \(data)")
                case .loading(progressState: let progressState):
                    print("Loading: \(progressState)")
            }

        }


    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

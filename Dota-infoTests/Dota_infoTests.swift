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
        let response: DataState = getHeroes.execute()

        switch (response) {
            case .response(response: let response):
                print("is a response: \(response.uiComponent)")
            case .data(data: let data):
                print("is a data: \(data.data)")
            case .loading(loading: let loading):
                    print("is a loading: \(loading.state)")
        }


    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

//
//  BeautyScanTests.swift
//  BeautyScanTests
//
//  Created by admin on 30.10.2023.
//

import XCTest
@testable import BeautyScan

final class BeautyScanTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension XCTestCase {    
    public func wait(for timeInterval: TimeInterval = 0.05) {
        let expectetion = self.expectation(description: "waiting")
        DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) {
            expectetion.fulfill()
        }
        waitForExpectations(timeout: timeInterval + 5.0)
    }
    
    open override func tearDown() {
        super.tearDown()
        wait()
    }
}

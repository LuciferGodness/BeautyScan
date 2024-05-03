//
//  HomeVMTest.swift
//  BeautyScanTests
//
//  Created by Admin on 4/25/24.
//

import XCTest
@testable import BeautyScan

final class HomeVMTest: XCTestCase {
    let mockView = MockedHomeView()
    var vm = HomeVM()
    
    override func setUpWithError() throws {
        vm = HomeVM()
        vm.view = mockView
    }

    override func tearDownWithError() throws {
        mockView.resetMockStates()
    }
    
    func testLoadData() {
        let apiService = FakeApiService(httpClient: ApiServices())
        
        vm.getData()
        XCTAssertNotNil(apiService.getData())
    }
    
    func testMockData() {
        let httpClient = MockApiService()
        let apiService = FakeApiService(httpClient: httpClient)
        vm.getData()
        apiService.getData()
        
        XCTAssertTrue(MockApiService.isCalled[.getDataForHome]!)
        mockView.reloadView()
        XCTAssertTrue(mockView.isCalled[.reloadView]!)
    }
}

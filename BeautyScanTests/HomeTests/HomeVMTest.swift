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
    var vm: HomeVM!
    var apiService: PApiServices!
    
    override func setUp() {
        super.setUp()
        vm = HomeVM()
        vm.view = mockView
        apiService = MockApiService()
        vm.apiService = apiService
    }

    override func tearDown() {
        mockView.resetMockStates()
        MockApiService.reset()
        super.tearDown()
    }
    
    func testLoadProductsDataSuccess() {
        vm.getData()
        XCTAssertTrue(MockApiService.isCalled[.getDataForHome]!)
        XCTAssertTrue(MockApiService.isCalled[.searchProduct]!)
        viewFuncCalled(funcType: .reloadView)
    }
    
    func testLoadProductsDataFail() {
        MockApiService.responseError = true
        vm.getData()
        
        XCTAssertTrue(MockApiService.isCalled[.getDataForHome]!)
        viewFuncCalled(funcType: .showAlert)
    }
    
    func viewFuncCalled(funcType: HomeViewFuncCalled) {
        XCTAssertTrue(mockView.isCalled[funcType] ?? false, "viewFuncCalled failed for \(funcType.rawValue)")
    }
}

//
//  DoctorsVMTest.swift
//  BeautyScanTests
//
//  Created by Admin on 5/28/24.
//

import XCTest
@testable import BeautyScan

final class DoctorsVMTest: XCTestCase {
    let mockView = MockedDoctorsView()
    var vm: DoctorsVM!
    var apiService: PApiServices!
    
    override func setUp() {
        super.setUp()
        vm = DoctorsVM()
        vm.view = mockView
        apiService = MockApiService()
        vm.apiService = apiService
    }

    override func tearDown() {
        mockView.resetMockStates()
        MockApiService.reset()
        super.tearDown()
    }
    
    func testLoadDataSuccess() {
        vm.getData()
        XCTAssertTrue(MockApiService.isCalled[.getUserAppointments]!)
        XCTAssertTrue(MockApiService.isCalled[.getAllDoctors]!)
        viewFuncCalled(funcType: .reloadTable)
    }
    
    func testLoadDataFail() {
        MockApiService.unautorized = true
        vm.getData()
        XCTAssertTrue(MockApiService.isCalled[.getUserAppointments]!)
        XCTAssertTrue(MockApiService.isCalled[.getAllDoctors]!)
        viewFuncCalled(funcType: .showAlert)
    }
    
    func viewFuncCalled(funcType: DoctorsViewFuncCalled) {
        XCTAssertTrue(mockView.isCalled[funcType] ?? false, "viewFuncCalled failed for \(funcType.rawValue)")
    }
}

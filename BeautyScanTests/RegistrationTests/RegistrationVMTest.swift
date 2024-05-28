//
//  ScanVMTest.swift
//  BeautyScanTests
//
//  Created by Admin on 5/28/24.
//

import XCTest
@testable import BeautyScan

final class RegistrationVMTest: XCTestCase {
    let mockView = MockedRegistrationView()
    var vm: RegistrationVM!
    var apiService: PApiServices!

    override func setUp() {
        super.setUp()
        vm = RegistrationVM()
        vm.view = mockView
        apiService = MockApiService()
        vm.apiService = apiService
    }

    override func tearDown() {
        mockView.resetMockStates()
        MockApiService.reset()
        super.tearDown()
    }
    
    func testRequestCodeSuccess() {
        vm.requestCode(phone: "+79780000000")
        XCTAssertTrue(MockApiService.isCalled[.getCodeForLogin]!)
    }
    
    func testRequestCodeFail() {
        MockApiService.responseError = true
        vm.requestCode(phone: "+79780000000")
        XCTAssertTrue(MockApiService.isCalled[.getCodeForLogin]!)
        viewFuncCalled(funcType: .showAlert)
    }
    
    func testVerifyCodeSuccess() {
        vm.verifyCode(phoneNumber: "+79780000000", code: "123445")
        XCTAssertTrue(MockApiService.isCalled[.verifyCode]!)
        viewFuncCalled(funcType: .openHome)
    }
    
    func testVerifyCodeFail() {
        MockApiService.responseError = true
        vm.verifyCode(phoneNumber: "+79780000000", code: "123445")
        XCTAssertTrue(MockApiService.isCalled[.verifyCode]!)
        viewFuncCalled(funcType: .showAlert)
    }

    func viewFuncCalled(funcType: RegistrationViewFuncCalled) {
        XCTAssertTrue(mockView.isCalled[funcType] ?? false, "viewFuncCalled failed for \(funcType.rawValue)")
    }
}

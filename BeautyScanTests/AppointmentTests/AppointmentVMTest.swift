//
//  AppointmentVMTest.swift
//  BeautyScanTests
//
//  Created by Admin on 5/28/24.
//

import XCTest
@testable import BeautyScan

final class AppointmentVMTest: XCTestCase {
    let mockView = MockedAppointmentView()
    var vm: AppointmentVM!
    var apiService: PApiServices!
    
    override func setUp() {
        super.setUp()
        vm = AppointmentVM(id: 1)
        vm.view = mockView
        apiService = MockApiService()
        vm.apiService = apiService
    }

    override func tearDown() {
        mockView.resetMockStates()
        MockApiService.reset()
        super.tearDown()
    }
    
    func testLoadAppointments() {
        vm.getAppointment()
        XCTAssertTrue(MockApiService.isCalled[.getDoctorInfo]!)
        viewFuncCalled(funcType: .reloadTable)
    }
    
    func testBookAppointment() {
        vm.bookAppointment(appointmentId: 1)
        XCTAssertTrue(MockApiService.isCalled[.bookAppointment]!)
        viewFuncCalled(funcType: .showAlert)
    }
    
    func viewFuncCalled(funcType: AppointmentViewFuncCalled) {
        XCTAssertTrue(mockView.isCalled[funcType] ?? false, "viewFuncCalled failed for \(funcType.rawValue)")
    }
}

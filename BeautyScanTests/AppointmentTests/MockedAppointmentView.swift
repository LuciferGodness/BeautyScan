//
//  MockAppointmentView.swift
//  BeautyScanTests
//
//  Created by Admin on 5/28/24.
//

import XCTest
@testable import BeautyScan

enum AppointmentViewFuncCalled: String {
    case startLoading
    case endLoading
    case showAlert
    case reloadTable
    case previousScreen
}

final class MockedAppointmentView: PAppointmentVC {
    var isCalled: [AppointmentViewFuncCalled: Bool] = [:]
    
    func reloadTable() {
        isCalled[.reloadTable] = true
    }
    
    func returnOnPreviousScreen() {
        isCalled[.previousScreen] = true
    }
    
    func startLoading() {
        isCalled[.startLoading] = true
    }
    
    func endLoading() {
        isCalled[.endLoading] = true
    }
    
    func showAlert(message: String?, _ completion: (() -> Void)?, title: String?, okTitle: String) {
        isCalled[.showAlert] = true
    }
    
    func resetMockStates() {
        isCalled = [:]
    }
}

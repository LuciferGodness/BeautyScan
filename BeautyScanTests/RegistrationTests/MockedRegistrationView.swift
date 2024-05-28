//
//  MockedScanView.swift
//  BeautyScanTests
//
//  Created by Admin on 5/28/24.
//

import XCTest
@testable import BeautyScan

enum RegistrationViewFuncCalled: String{
    case openHome
    case startLoading
    case endloading
    case showAlert
}

final class MockedRegistrationView: PRegistrationVC {
    var isCalled: [RegistrationViewFuncCalled: Bool] = [:]
    
    func openHome() {
        isCalled[.openHome] = true
    }
    
    func startLoading() {
        isCalled[.startLoading] = true
    }
    
    func endLoading() {
        isCalled[.endloading] = true
    }
    
    func showAlert(message: String?, _ completion: (() -> Void)?, title: String?, okTitle: String) {
        isCalled[.showAlert] = true
    }
    
    func resetMockStates() {
        isCalled = [:]
    }
}

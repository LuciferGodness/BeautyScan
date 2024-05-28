//
//  MockedDoctorsView.swift
//  BeautyScanTests
//
//  Created by Admin on 5/28/24.
//

import XCTest
@testable import BeautyScan

enum DoctorsViewFuncCalled: String{
    case reloadTable
    case startLoading
    case endLoading
    case showAlert
}

final class MockedDoctorsView: PDoctorsVC {
    var isCalled: [DoctorsViewFuncCalled: Bool] = [:]
    
    func reloadTable() {
        isCalled[.reloadTable] = true
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

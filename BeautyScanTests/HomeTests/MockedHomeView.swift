//
//  MockedHomeView.swift
//  BeautyScanTests
//
//  Created by Admin on 4/25/24.
//

import XCTest
@testable import BeautyScan

enum HomeViewFuncCalled: String{
    case reloadView
    case startLoading
    case endLoading
    case showAlert
}

final class MockedHomeView: PHomeVC {
    var isCalled: [HomeViewFuncCalled: Bool] = [:]
    
    func reloadView() {
        isCalled[.reloadView] = true
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

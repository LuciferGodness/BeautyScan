//
//  MockedAboutSkinView.swift
//  BeautyScanTests
//
//  Created by Admin on 5/28/24.
//

import XCTest
@testable import BeautyScan

enum AboutSkinViewFuncCalled: String{
    case displayQuestion
    case openSideMenu
    case reloadView
    case startLoading
    case endLoading
    case showAlert
}

final class MockedAboutSkinView: PAboutSkinVC {
    var isCalled: [AboutSkinViewFuncCalled: Bool] = [:]
    
    func displayQuestion(_ question: String, options: [String]) {
        isCalled[.displayQuestion] = true
    }
    
    func openSideMenu() {
        isCalled[.openSideMenu] = true
    }
    
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

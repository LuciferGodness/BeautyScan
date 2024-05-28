//
//  AboutSkinVMTest.swift
//  BeautyScanTests
//
//  Created by Admin on 5/28/24.
//

import XCTest
@testable import BeautyScan

final class AboutSkinVMTest: XCTestCase {
    let mockView = MockedAboutSkinView()
    var vm: AboutSkinVM!
    var apiService: PApiServices!

    override func setUp() {
        super.setUp()
        vm = AboutSkinVM()
        vm.view = mockView
        apiService = MockApiService()
        vm.apiService = apiService
    }

    override func tearDown() {
        mockView.resetMockStates()
        MockApiService.reset()
        super.tearDown()
    }
    
    func testGetQuestionsSuccess() {
        vm.getQuestions()
        XCTAssertTrue(MockApiService.isCalled[.getQuestions]!)
    }

    func viewFuncCalled(funcType: AboutSkinViewFuncCalled) {
        XCTAssertTrue(mockView.isCalled[funcType] ?? false, "viewFuncCalled failed for \(funcType.rawValue)")
    }
}

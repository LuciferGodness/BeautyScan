//
//  MockApiService.swift
//  BeautyScanTests
//
//  Created by Admin on 4/25/24.
//

import XCTest
import RxSwift
@testable import BeautyScan

enum MockApiServiceFunc {
    case getDataForHome
    case searchProduct
    case getCodeForLogin
    case getDoctorInfo
    case verifyCode
    case getQuestions
    case bookAppointment
    case getUserAppointments
    case getAllDoctors
}

final class MockApiService: PApiServices {
    static var isCalled: [MockApiServiceFunc: Bool] = [:]
    static var unautorized = false
    static var responseError = false
    
    let repository = MocksRepository()
    
    static func reset() {
        isCalled = [:]
        unautorized = false
        responseError = false
    }
    
    let doctor = """
    {
      "message": "Your verification code is: 123456"
    }
    """.data(using: .utf8)!
    
    func getDataForHome() -> Single<HomeDTO> {
        MockApiService.isCalled[.getDataForHome] = true
        let homeDTO = repository.homeDTO
        if MockApiService.responseError {
            return Single.error(ApiError.responseError)
        } else {
            return createMockSingle(mockedData: homeDTO)
        }
    }
    
    func searchProduct(producrName: String) -> Single<SearchProductDTO> {
        MockApiService.isCalled[.searchProduct] = true
        let searchDTO = repository.searchProductDTO
        return createMockSingle(mockedData: searchDTO)
    }
    
    func getCodeForLogin(phone: String?) -> Single<SMSResponseDTO> {
        MockApiService.isCalled[.getCodeForLogin] = true
        let messageDTO = repository.smsResponseDTO
        if MockApiService.responseError {
            return Single.error(ApiError.responseError)
        } else {
            return createMockSingle(mockedData: messageDTO)
        }
    }
    
    func verifyLoginCode(phoneNumber: String, code: String) -> Single<VerifyResponseDTO> {
        MockApiService.isCalled[.verifyCode] = true
        let verifyDTO = repository.verifyResponseDTO
        if MockApiService.responseError {
            return Single.error(ApiError.responseError)
        } else {
            return createMockSingle(mockedData: verifyDTO)
        }
    }
    
    func getQuestions() -> Single<[QuestionsDTO]> {
        MockApiService.isCalled[.getQuestions] = true
        let questionsDTO = repository.questionsDTO
        return createMockSingle(mockedData: questionsDTO)
    }
    
    func getDoctorInfo(doctorId: Int) -> Single<DoctorInfoDTO> {
        MockApiService.isCalled[.getDoctorInfo] = true
        let doctorInfoDTO = repository.doctorInfoDTO
        return createMockSingle(mockedData: doctorInfoDTO)
    }
    
    func bookAppointment(appointmentId: Int) -> Single<SMSResponseDTO> {
        MockApiService.isCalled[.bookAppointment] = true
        let messageDTO = repository.smsResponseDTO
        return createMockSingle(mockedData: messageDTO)
    }
    
    func getUserAppointments() -> Single<[UserAppointmentsDTO]> {
        MockApiService.isCalled[.getUserAppointments] = true
        let userAppointmentsDTO = repository.userAppointmentsDTO
        if MockApiService.unautorized {
            return Single.error(ApiError.unautorized)
        } else {
            return createMockSingle(mockedData: userAppointmentsDTO)
        }
    }
    
    func getAllDoctors() -> Single<[DoctorsDTO]> {
        MockApiService.isCalled[.getAllDoctors] = true
        let allDoctors = repository.doctorsDTO
        if MockApiService.unautorized {
            return Single.error(ApiError.unautorized)
        } else {
            return createMockSingle(mockedData: allDoctors)
        }
    }
    
    private func createMockSingle<T>(mockedData: T) -> Single<T> {
        return Single.just(mockedData)
    }
}

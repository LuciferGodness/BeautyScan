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
}

struct FakeApiService {
    let httpClient: PApiServices
    
    func getData() -> Single<HomeDTO> {
        return httpClient.getDataForHome()
    }
}

final class MockApiService: PApiServices {
    static var isCalled: [MockApiServiceFunc: Bool] = [:]
    
    static func reset() {
        isCalled = [:]
    }
    
    let jsonData = """
    {
      "status": "success",
      "hits": [
        {
          "NAME": "Product 1",
          "ARTICLE": "123456",
          "BRAND": {
            "ID": 1,
            "CODE": "BRD1",
            "NAME": "Brand A"
          },
          "COVER": {
            "SRC": "https://example.com/image1.jpg",
            "SRC_M": "https://example.com/image1_m.jpg",
            "SRC_S": "https://example.com/image1_s.jpg"
          },
          "PRICE": {
            "CURRENT": 50,
            "RETAIL": 60,
            "PROFESSIONAL": 45,
            "OLD": 70
          },
          "VOTES": {
            "REVIEWS": 10,
            "RATING": 4.5,
            "RATING_COUNT": 20,
            "TEXT": "Great product!"
          },
          "FLAG_SHOW_PRICE": true,
          "FLAG_CAN_BUY": true,
          "FLAG_SUPPLIER_NO_ORDER": false
        }
      ]
    }
    """.data(using: .utf8)!
    
    let searchProduct = """
    {
      "items": [
        {
          "title": "Product 1",
          "link": "https://example.com/product1",
          "displayLink": "example.com",
          "formattedUrl": "https://example.com/product1"
        },
        {
          "title": "Product 2",
          "link": "https://example.com/product2",
          "displayLink": "example.com",
          "formattedUrl": "https://example.com/product2"
        }
      ],
      "queries": {
        "request": [
          {
            "searchTerms": "search term 1"
          },
          {
            "searchTerms": "search term 2"
          }
        ]
      }
    }
    """.data(using: .utf8)!
    
    let message = """
    {
      "message": "Your verification code is: 123456"
    }
    """.data(using: .utf8)!
    
    let doctor = """
    {
      "message": "Your verification code is: 123456"
    }
    """.data(using: .utf8)!
    
    func getDataForHome() -> Single<HomeDTO> {
        MockApiService.isCalled[.getDataForHome] = true
        let homeDTO = try! JSONDecoder().decode(HomeDTO.self, from: jsonData)
        return createMockSingle(mockedData: homeDTO)
    }
    
    func searchProduct(producrName: String) -> Single<SearchProductDTO> {
        MockApiService.isCalled[.searchProduct] = true
        let searchDTO = try! JSONDecoder().decode(SearchProductDTO.self, from: searchProduct)
        return createMockSingle(mockedData: searchDTO)
    }
    
    func getCodeForLogin(phone: String?) -> Single<SMSResponseDTO> {
        MockApiService.isCalled[.getCodeForLogin] = true
        let messageDTO = try! JSONDecoder().decode(SMSResponseDTO.self, from: message)
        return createMockSingle(mockedData: messageDTO)
    }
    
    func getDoctorInfo(doctorId: Int) -> Single<DoctorInfoDTO> {
        MockApiService.isCalled[.getDoctorInfo] = true
        let doctorDTO = try! JSONDecoder().decode(DoctorInfoDTO.self, from: doctor)
        return createMockSingle(mockedData: doctorDTO)
    }
    
    func verifyLoginCode(phoneNumber: String, code: String) -> Single<VerifyResponseDTO> {
        <#code#>
    }
    
    func getQuestions() -> Single<[QuestionsDTO]> {
        <#code#>
    }
    
    func bookAppointment(appointmentId: Int) -> Single<SMSResponseDTO> {
        <#code#>
    }
    
    func getUserAppointments() -> Single<[UserAppointmentsDTO]> {
        <#code#>
    }
    
    func getAllDoctors() -> Single<[DoctorsDTO]> {
        <#code#>
    }
    
    private func createMockSingle<T>(mockedData: T) -> Single<T> {
        return Single.just(mockedData)
    }
}

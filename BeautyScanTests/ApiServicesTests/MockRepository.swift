//
//  MockRepository.swift
//  BeautyScanTests
//
//  Created by Admin on 5/28/24.
//

import Foundation
@testable import BeautyScan

final class MocksRepository {
    let testBundle: Bundle
    let testBundleId = "amos.BeautyScanTests"
    
    init() {
        testBundle = Bundle(identifier: testBundleId)!
    }
    
    func loadJSON<T: Decodable>(filename: String, type: T.Type) -> T {
        guard let url = testBundle.path(forResource: filename, ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: url)),
              let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            fatalError("Failed to load and decode JSON file: \(filename)")
        }
        return decodedData
    }
    
    var homeDTO: HomeDTO {
        return loadJSON(filename: "home", type: HomeDTO.self)
    }
    
    var searchProductDTO: SearchProductDTO {
        return loadJSON(filename: "searchProduct", type: SearchProductDTO.self)
    }
    
    var smsResponseDTO: SMSResponseDTO {
        return loadJSON(filename: "message", type: SMSResponseDTO.self)
    }
    
    var verifyResponseDTO: VerifyResponseDTO {
        return loadJSON(filename: "verifyResponse", type: VerifyResponseDTO.self)
    }
    
    var questionsDTO: [QuestionsDTO] {
        return loadJSON(filename: "questions", type: [QuestionsDTO].self)
    }
    
    var doctorInfoDTO: DoctorInfoDTO {
        return loadJSON(filename: "doctorInfo", type: DoctorInfoDTO.self)
    }
    
    var userAppointmentsDTO: [UserAppointmentsDTO] {
        return loadJSON(filename: "userAppointments", type: [UserAppointmentsDTO].self)
    }
    
    var doctorsDTO: [DoctorsDTO] {
        return loadJSON(filename: "doctors", type: [DoctorsDTO].self)
    }
}

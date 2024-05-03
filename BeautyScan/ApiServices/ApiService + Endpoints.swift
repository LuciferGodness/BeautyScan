//
//  ApiService + Endpoints.swift
//  BeautyScan
//
//  Created by admin on 10.11.2023.
//

import Foundation
import RxSwift

protocol PApiServices {
    func getDataForHome() -> Single<HomeDTO>
    func searchProduct(producrName: String) -> Single<SearchProductDTO>
    func getCodeForLogin(phone: String?) -> Single<SMSResponseDTO>
    func getDoctorInfo(doctorId: Int) -> Single<DoctorInfoDTO>
    func verifyLoginCode(phoneNumber: String, code: String) -> Single<VerifyResponseDTO>
    func getQuestions() -> Single<[QuestionsDTO]>
}

extension ApiServices: PApiServices {
    func getDataForHome() -> Single<HomeDTO> {
        sendRequest(url: .homeURL)
    }
    
    func searchProduct(producrName: String) -> Single<SearchProductDTO> {
        sendRequest(url: .searchProduct(productName: producrName))
    }
    
    func getCodeForLogin(phone: String?) -> Single<SMSResponseDTO> {
        sendRequest(url: .registrationCode, model: SMSRequestModel(phoneNumber: phone ?? ""), method: .post, contentType: "application/json")
    }
    
    func verifyLoginCode(phoneNumber: String, code: String) -> Single<VerifyResponseDTO> {
        sendRequest(url: .verifyCode, model: VerifyRequestModel(phoneNumber: phoneNumber, code: code), method: .post, contentType: "application/json")
            .map { (verifyResponseDTO: VerifyResponseDTO) in
                AppState.current.accessToken = verifyResponseDTO.token
                return verifyResponseDTO
            }
    }
    
    func getQuestions() -> Single<[QuestionsDTO]> {
        sendRequest(url: .questions)
    }
    
    func getDoctorInfo(doctorId: Int) -> Single<DoctorInfoDTO> {
        sendRequest(url: .getDoctorInfo(doctorId: doctorId))
    }
}

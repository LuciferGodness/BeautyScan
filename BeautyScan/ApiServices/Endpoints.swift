//
//  Endpoints.swift
//  BeautyScan
//
//  Created by admin on 10.11.2023.
//

import Foundation

enum Endpoints {
    case homeURL
    case searchProduct(productName: String)
    case searchUsersProduct(productName: String)
    case registrationCode
    case verifyCode
    case skinTypeURL
    case getDoctorInfo(doctorId: Int)
    case questions
    
    var string: String {
        switch self {
        case .homeURL:
            return "\(AppConfig.domain)api/v1/blocks/products_top/"
        case .registrationCode:
            return AppConfig.registrationCodeUrl
        case let .searchProduct(productName: productName):
            return "\(AppConfig.googleDomain)\(productName)"
        case .verifyCode:
            return AppConfig.verifyCodeUrl
        case .skinTypeURL:
            return "https://skin-analyze.p.rapidapi.com/facebody/analysis/skinanalyze"
        case let .searchUsersProduct(productName: productName):
            return "\(AppConfig.searchUsersProduct)\(productName)"
        case let .getDoctorInfo(doctorId: doctorId):
            return "\(AppConfig.ngrokDomain)/doctors/\(doctorId)/appointments"
        case .questions:
            return "\(AppConfig.ngrokDomain)/questions"
        }
    }
}

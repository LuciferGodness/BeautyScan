//
//  LocalizationKeys.swift
//  BeautyScan
//
//  Created by Admin on 4/6/24.
//

import Foundation

enum LocalizationKeys: String {
    case homeScreen
    case aboutSkinScreen
    case appointment
    case doctors
    
    case scan
    case learnSkinType
    case support
    case logout
    
    case firstRegText
    case secondRegText
    case thirdRegText
    case fourthRegText
    case fifthRegText
    case sixthRegText
    case scannerHint
    
    case productLink
    
    case selectDate
    case error
    case ok
    case rubles
    
    case general
    case ingredients
    case alternatives
    case assetType
    case undefined
    
    case skinType
    case yourType
    case gptRequest
    case veryOily
    case oily
    case dry
    case veryDry
    case wrincled
    case elastic
    case pigmented
    case notPigmented
    case verySensitive
    case sensitive
    case resistant
    case veryResistant
    
    case myAppointments
    case doctorsSpecialty
    
    func localized() -> String {
        rawValue.localized()
    }
}

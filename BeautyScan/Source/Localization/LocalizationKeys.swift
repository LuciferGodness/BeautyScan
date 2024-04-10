//
//  LocalizationKeys.swift
//  BeautyScan
//
//  Created by Admin on 4/6/24.
//

import Foundation

enum LocalizationKeys: String {
    case firstRegText
    case secondRegText
    case thirdRegText
    case fourthRegText
    case fifthRegText
    case sixthRegText
    case scannerHint
    
    case productLink
    
    func localized() -> String {
        rawValue.localized()
    }
}

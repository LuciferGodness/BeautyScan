//
//  SkinTypes.swift
//  BeautyScan
//
//  Created by Admin on 5/1/24.
//

import Foundation

enum SkinTestPart: Int {
    case oily = 1
    case resistent
    case pigmented
    case wrinkled

    func calculateTestResult(for score: Double) -> String {
        switch self {
        case .oily:
            switch score {
            case 34...44:
                return LocalizationKeys.veryOily.localized()
            case 27...33:
                return LocalizationKeys.oily.localized()
            case 17...26:
                return LocalizationKeys.dry.localized()
            case 11...16:
                return LocalizationKeys.veryDry.localized()
            default:
                return LocalizationKeys.undefined.localized()
            }
        case .resistent:
            switch score {
            case 34...72:
                return LocalizationKeys.verySensitive.localized()
            case 20...33:
                return LocalizationKeys.sensitive.localized()
            case 25...29:
                return LocalizationKeys.resistant.localized()
            case 17...24:
                return LocalizationKeys.veryResistant.localized()
            default:
                return LocalizationKeys.undefined.localized()
            }
        case .pigmented:
            switch score {
            case 29...52:
                return LocalizationKeys.pigmented.localized()
            case 13...28:
                return LocalizationKeys.notPigmented.localized()
            default:
                return LocalizationKeys.undefined.localized()
            }
        case .wrinkled:
            switch score {
            case 20...40:
                return LocalizationKeys.elastic.localized()
            case 41...85:
                return LocalizationKeys.wrincled.localized()
            default:
                return LocalizationKeys.undefined.localized()
            }
        }
    }
}

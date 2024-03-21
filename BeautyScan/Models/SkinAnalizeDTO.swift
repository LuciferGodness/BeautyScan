//
//  SimpleDTO.swift
//  BeautyScan
//
//  Created by admin on 12.02.2024.
//

import Foundation

struct SkinAnalizeDTO: Decodable {
    let message: String?
    let result: Result
    
    struct Result: Decodable {
        let skinType: SkinType
        let poresLeftCheek: Detail
        let nasolabialFold: Detail
        let eyePouch: Detail
        let foreheadWrinkle: Detail
        let skinSpot: Detail
        let acne: Detail
        let poresForehead: Detail
        let poresJaw: Detail
        let leftEyelids: Detail
        let eyeFinelines: Detail
        let darkCircle: Detail
        let crowsFeet: Detail
        let poresRightCheek: Detail
        let blackhead: Detail
        let glabellaWrinkle: Detail
        let mole: Detail
        let rightEyelids: Detail
        
        enum CodingKeys: String, CodingKey {
            case skinType = "skin_type"
            case poresLeftCheek = "pores_left_cheek"
            case nasolabialFold = "nasolabial_fold"
            case eyePouch = "eye_pouch"
            case foreheadWrinkle = "forehead_wrinkle"
            case skinSpot = "skin_spot"
            case acne = "acne"
            case poresForehead = "pores_forehead"
            case poresJaw = "pores_jaw"
            case leftEyelids = "left_eyelids"
            case eyeFinelines = "eye_finelines"
            case darkCircle = "dark_circle"
            case crowsFeet = "crows_feet"
            case poresRightCheek = "pores_right_cheek"
            case blackhead = "blackhead"
            case glabellaWrinkle = "glabella_wrinkle"
            case mole = "mole"
            case rightEyelids = "right_eyelids"
        }
        
        struct SkinType: Decodable {
            let type: Int
            
            enum CodingKeys: String, CodingKey {
                case type = "skin_type"
            }
            
            init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                
                type = try values.decode(Int.self, forKey: .type)
            }
        }
        
        struct Detail: Decodable {
            let confidence: Double
            let value: Int
        }
    }
    
    func getSkinTypeDescription() -> String? {
        let skinType = result.skinType.type
        
        let skinTypeDescriptions: [Int: String] = [
            0: "Oily skin",
            1: "Dry skin",
            2: "Neutral skin",
            3: "Combination skin"
        ]
        
        return skinTypeDescriptions[skinType] ?? "Unknown skin type"
    }
    
    enum EyelidType {
        case leftEyelid
        case rightEyelid
    }
    
    func getEyelidsDescription(eyelidType: EyelidType) -> String? {
        guard let eyelidTypeValue: Int = {
            switch eyelidType {
            case .leftEyelid:
                return result.leftEyelids.value
            case .rightEyelid:
                return result.rightEyelids.value
            }
        }() else {
            return nil
        }
        
        let eyelidTypeDescriptions: [Int: String] = [
            0: "Single eyelids",
            1: "Parallel Double Eyelids",
            2: "Scalloped Double Eyelids",
        ]
        
        return eyelidTypeDescriptions[eyelidTypeValue] ?? "Unknown eyelid type"
    }
    //TODO: move to localizable
    func getTestResultsDescription<T>(testType: (Result) -> T) -> String? {
        guard let testValue = testType(result) as? Int else {
            return nil
        }
        
        let testDescriptions: [Int: String] = [
            0: "No",
            1: "Yes",
        ]
        
        return testDescriptions[testValue] ?? "Unknown result"
    }
}

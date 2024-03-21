//
//  SMSRequestModel.swift
//  BeautyScan
//
//  Created by admin on 16.12.2023.
//

import Foundation

struct SMSRequestModel: PFormEncoding {
    let phoneNumber: String
    
    func toFormData() -> [String: Any] {
        return [
            "phoneNumber": phoneNumber
        ]
    }
}

//
//  VerifyRequestModel.swift
//  BeautyScan
//
//  Created by admin on 11.01.2024.
//

import Foundation

struct VerifyRequestModel: PFormEncoding {
    let phoneNumber: String
    let code: String
    
    func toFormData() -> [String: Any] {
        return [
            "phoneNumber": phoneNumber,
            "code": code,
        ]
    }
}

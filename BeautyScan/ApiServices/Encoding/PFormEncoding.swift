//
//  PFormEncoding.swift
//  BeautyScan
//
//  Created by admin on 16.12.2023.
//

import Foundation

protocol PFormEncoding where Self: Encodable {
    func toFormData() -> [String: Any]
}

extension PFormEncoding {
    var formsData: String {
        return toFormData()
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
    }
}

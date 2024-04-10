//
//  String+Extension.swift
//  BeautyScan
//
//  Created by Admin on 4/6/24.
//

import Foundation

extension String {
    func localized() -> String {
        Bundle.main.localizedString(forKey: self, value: nil, table: nil)
    }
}

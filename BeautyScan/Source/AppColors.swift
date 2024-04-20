//
//  AppColors.swift
//  BeautyScan
//
//  Created by admin on 15.12.2023.
//

import UIKit

enum AppColors: String {
    case blackAsset
    case whiteAsset
    case grayAsset
    case menuBackgroundColor
    case textFieldBackground
    case buttonColor
    
    var color: UIColor? {
        UIColor(named: self.rawValue)
    }
}

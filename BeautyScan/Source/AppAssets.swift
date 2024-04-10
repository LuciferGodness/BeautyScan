//
//  AppAssets.swift
//  BeautyScan
//
//  Created by admin on 22.11.2023.
//

import Foundation
import UIKit

enum AppAssets: String {
    case menuImage
    case starIcon
    case next
    case menuBackground
    case scanIcon
    case skinIcon
    case supportIcon
    case logoutIcon
    case homeIcon
    case articlesIcon
    
    case skinExample
    case scannerFrame
    
    var image: UIImage? {
        rawValue.image
    }
}

extension String {
    var image: UIImage? {
        let image = UIImage(named: self)
        
        return image
    }
}

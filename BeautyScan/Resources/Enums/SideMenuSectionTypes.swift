//
//  SideMenuSectionTypes.swift
//  BeautyScan
//
//  Created by Admin on 3/10/24.
//

import Foundation
import UIKit

enum Section {
    case profile
    case mainOptions([MenuItem])
    case additionalOptions([MenuItem])
    
    var items: [MenuItem] {
        switch self {
        case .profile:
            return []
        case .mainOptions(let items), .additionalOptions(let items):
            return items
        }
    }
    
    var rowHeight: CGFloat {
        switch self {
        case .profile:
            return 200
        case .mainOptions, .additionalOptions:
            return 45
        }
    }
    
    var numberOfRows: Int {
        switch self {
        case .profile:
            return 1
        case .mainOptions:
            return 3
        case .additionalOptions:
            return 2
        }
    }
}

enum MenuItem {
    case home
    case scanProduct
    case learnSkinType
    case requestSupport
    case logout
    
    var label: String {
        switch self {
        case .home: return LocalizationKeys.homeScreen.localized()
        case .scanProduct: return LocalizationKeys.scan.localized()
        case .learnSkinType: return LocalizationKeys.learnSkinType.localized()
        case .requestSupport: return LocalizationKeys.support.localized()
        case .logout: return LocalizationKeys.logout.localized()
        }
    }
    
    var image: UIImage? {
        switch self {
        case .home: return AppAssets.homeIcon.image
        case .scanProduct: return AppAssets.scanIcon.image
        case .learnSkinType: return AppAssets.skinIcon.image
        case .requestSupport: return AppAssets.supportIcon.image
        case .logout: return AppAssets.logoutIcon.image
        }
    }
}

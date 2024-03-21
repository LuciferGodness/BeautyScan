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
    
    //TODO: addLocalizable
    var label: String {
        switch self {
        case .home: return "Home"
        case .scanProduct: return "Scan Product"
        case .learnSkinType: return "Learn Skin Type"
        case .requestSupport: return "Request Support"
        case .logout: return "Logout"
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

//
//  AppState.swift
//  BeautyScan
//
//  Created by admin on 17.02.2024.
//

import Foundation
import SideMenu

protocol RootViewControllerDelegate: AnyObject {
    func updateRootViewController(window: UIWindow)
}

final class AppState {
    private var delegate: RootViewControllerDelegate = SceneDelegate()
    static var current = AppState()
    
    @UserDefault(key: UserDefaultsKey.skinType.rawValue, defaultValue: nil) var skinType: String?
    @UserDefault(key: UserDefaultsKey.rightEyelid.rawValue, defaultValue: nil) var rightEyelid: String?
    @UserDefault(key: UserDefaultsKey.leftEyelid.rawValue, defaultValue: nil) var leftEyelid: String?
    @UserDefault(key: UserDefaultsKey.acne.rawValue, defaultValue: nil) var acne: String?
    @UserDefault(key: UserDefaultsKey.blackhead.rawValue, defaultValue: nil) var blackhead: String?
    @KeychainToken(key: .authToken) var accessToken: String?
    
    func logout() {
        guard let window = UIApplication.shared.windows.first else {
            fatalError("Window is nil when attempting to update root view controller.")
        }
        SideMenuManager.default.leftMenuNavigationController?.dismiss(animated: false)
        delegate.updateRootViewController(window: window)
        accessToken = nil
    }
}

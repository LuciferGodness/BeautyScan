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
    
    @UserDefault(key: UserDefaultsKey.oilySkin.rawValue, defaultValue: "") var oilySkin: String
    @UserDefault(key: UserDefaultsKey.resistentSkin.rawValue, defaultValue: "") var resistentSkin: String
    @UserDefault(key: UserDefaultsKey.pigmentedSkin.rawValue, defaultValue: "") var pigmentedSkin: String
    @UserDefault(key: UserDefaultsKey.wrinkledSkin.rawValue, defaultValue: "") var wrinkledSkin: String
    @Keychain(key: .authToken) var accessToken: String?
    
    func logout() {
        guard let window = UIApplication.shared.windows.first else {
            fatalError("Window is nil when attempting to update root view controller.")
        }
        SideMenuManager.default.leftMenuNavigationController?.dismiss(animated: false)
        delegate.updateRootViewController(window: window)
        accessToken = nil
    }
}

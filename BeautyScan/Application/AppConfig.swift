//
//  AppConfig.swift
//  BeautyScan
//
//  Created by admin on 23.12.2023.
//

import Foundation

enum AppConfig {
    static var domain: String {
        "https://www.proficosmetics.ru/"
    }
    
    static var ngrokDomain: String {
        "https://dec6-91-197-3-158.ngrok-free.app"
    }
    
    static var googleDomain: String {
        "https://www.googleapis.com/customsearch/v1?key=AIzaSyByAbyMao9DKZHwflfjfYGXuOE-UX3cKWc&cx=938b6a59759f94e6d&q="
    }
    
    static var verifyCodeUrl: String {
        "\(ngrokDomain)/verify"
    }
    
    static var registrationCodeUrl: String {
        "\(ngrokDomain)/getCode"
    }
    
    static var openAIText: String {
        LocalizationKeys.gptRequest.localized() + "\(AppState.current.oilySkin) " + "\(AppState.current.pigmentedSkin) " + "\(AppState.current.resistentSkin) " + "\(AppState.current.wrinkledSkin) "
    }
}

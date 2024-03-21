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
        "https://53bc-91-197-3-158.ngrok-free.app"
    }
    
    static var googleDomain: String {
        "https://www.googleapis.com/customsearch/v1?key=AIzaSyByAbyMao9DKZHwflfjfYGXuOE-UX3cKWc&cx=938b6a59759f94e6d&q="
    }
    
    static var verifyCodeUrl: String {
        "\(ngrokDomain)/verify"
    }
    
    static var searchUsersProduct: String {
        "https://makeup-api.herokuapp.com/api/v1/products.json?brand="
    }
    
    static var registrationCodeUrl: String {
        "\(ngrokDomain)/getCode"
    }
    
    static var openAIText: String {
        //TODO: refactor
        "тип кожи: \(AppState.current.skinType ?? ""), acne: \(AppState.current.acne ?? ""); Ответ дай в формате: Общее: Информация о компании, описание продукта (подходит или не подходит данном типу кожи, применение, противопоказания, плюсы/минусы); Ингредиенты: состав продукта (опиши влияние каждого пункта состава на кожу), состав должен быть без повторений, насколько хорош продукт и когда должны появиться первые результаты; Альтернативы: рекомендации похожих продуктов(приведи реальные конкретные примеры и ссылки на них); (только эти три заголовка должны присутствовать)"
    }
    //TODO: refactor?
    /*static func analyzeSkinRequest(response: SkinAnalizeDTO) -> String {
        return "Ответ дай на русском. Проанализируй и дай рекомендации: тип кожи: \(response.getSkinTypeDescription()), поры(левая щека, правая щека, подбородок, лоб): \(response.getTestResultsDescription(testType: { $0.poresLeftCheek.value })), \(response.getTestResultsDescription(testType: { $0.poresRightCheek.value })), \(response.getTestResultsDescription(testType: { $0.poresJaw.value })), \(response.getTestResultsDescription(testType: { $0.poresForehead.value })) acne: \(response.getTestResultsDescription(testType: { $0.acne.value })), wrinkles(forehead, glabella): \(response.getTestResultsDescription(testType: { $0.foreheadWrinkle.value })), \(response.getTestResultsDescription(testType: { $0.glabellaWrinkle.value }))"
    }*/
    
    static var firstText: String {
        "Если вы здесь впервые, то вам высветятся вопросы для сбора информации о состоянии вашей кожи, чтобы мы лучше могли советовать вам продукты"
    }
    
    static var secondText: String {
        "Приложение поможет вам определить, какие продукты подходят именно для вас, учитывая особенности вашей кожи."
    }
    
    static var thirdText: String {
        "Откройте для себя персонализированные рекомендации по уходу за кожей, разработанные специально для вас и вашего типа кожи."
    }

    static var fourthText: String {
        "Узнайте больше о заботе о коже и найдите подходящие продукты."
    }

    static var fifthText: String {
        "Исследуйте мир красоты и ухода за кожей с нашим приложением, где каждый совет и рекомендация созданы с учетом вашей уникальной кожи."
    }

    static var sixthText: String {
        "Получите персонализированные рекомендации о продуктах для кожи, основанные на вашем стиле жизни, предпочтениях и уровне увлажнения кожи."
    }

}

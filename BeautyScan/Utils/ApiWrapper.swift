//
//  KeychainWrapper.swift
//  BeautyScan
//
//  Created by admin on 16.01.2024.
//

import Foundation

struct ApiKey {
    let serviceName: String
    let environmentKey: String
}

final class ApiKeyManager {
    static let apiKeys: [ApiKey] = [
        ApiKey(serviceName: "OpenAI", environmentKey: "OPENAI_API_KEY")
    ]
    
    static func getApiKey(forService service: String) -> String {
        guard let apiKey = apiKeys.first(where: { $0.serviceName == service }) else {
            return ""
        }
        return ProcessInfo.processInfo.environment[apiKey.environmentKey] ?? ""
    }
}

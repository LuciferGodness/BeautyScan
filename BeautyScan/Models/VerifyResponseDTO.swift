//
//  VerifyResponseDTO.swift
//  BeautyScan
//
//  Created by admin on 15.01.2024.
//

import Foundation

struct VerifyResponseDTO: Decodable {
    let message: String
    let token: String?
    
    private enum CodingKeys: String, CodingKey {
        case message
        case token
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.message = try container.decode(String.self, forKey: .message)
        self.token = try container.decode(String.self, forKey: .token)
    }
}

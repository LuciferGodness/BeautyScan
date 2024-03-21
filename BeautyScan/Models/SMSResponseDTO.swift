//
//  SMSResponseDTO.swift
//  BeautyScan
//
//  Created by admin on 17.12.2023.
//

import Foundation

struct SMSResponseDTO: Decodable {
    let message: String
    
    private enum CodingKeys: String, CodingKey {
        case message
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<SMSResponseDTO.CodingKeys> = try decoder.container(keyedBy: SMSResponseDTO.CodingKeys.self)
        self.message = try container.decode(String.self, forKey: SMSResponseDTO.CodingKeys.message)
    }
}

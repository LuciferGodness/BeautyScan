//
//  QuestionsDTO.swift
//  BeautyScan
//
//  Created by Admin on 4/20/24.
//

import Foundation

struct QuestionsDTO: Decodable {
    let id: Int
    let question: String
    let options: [String]
    let points: [Int]
    
    enum CodingKeys: String, CodingKey {
        case id
        case question
        case options
        case points
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        question = try values.decode(String.self, forKey: .question)
        options = try values.decode([String].self, forKey: .options)
        points = try values.decode([Int].self, forKey: .points)
    }
}

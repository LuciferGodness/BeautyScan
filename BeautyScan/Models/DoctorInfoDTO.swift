//
//  DoctorInfoDTO.swift
//  BeautyScan
//
//  Created by Admin on 4/14/24.
//

import Foundation

struct DoctorInfoDTO: Decodable {
    let id: Int
    let doctorName: String
    let specialty: String
    let description: String
    let price: Int
    let experience: Int
    let clinicAddress: String
    let date: [String]
    let available: [Int]
    
    enum CodingKeys: String, CodingKey {
        case id
        case doctorName = "doctor_name"
        case specialty
        case description
        case price
        case experience
        case clinicAddress = "clinic_address"
        case date
        case available
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        doctorName = try values.decode(String.self, forKey: .doctorName)
        specialty = try values.decode(String.self, forKey: .specialty)
        date = try values.decode([String].self, forKey: .date)
        available = try values.decode([Int].self, forKey: .available)
        description = try values.decode(String.self, forKey: .description)
        price = try values.decode(Int.self, forKey: .price)
        experience = try values.decode(Int.self, forKey: .experience)
        clinicAddress = try values.decode(String.self, forKey: .clinicAddress)
    }
}

//
//  DoctorsDTO.swift
//  BeautyScan
//
//  Created by Admin on 5/16/24.
//

import Foundation

struct DoctorsDTO: Decodable {
    let id: Int
    let name: String
    let specialty: String
    let clinicAddress: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case specialty
        case clinicAddress = "clinic_address"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        specialty = try values.decode(String.self, forKey: .specialty)
        clinicAddress = try values.decode(String.self, forKey: .clinicAddress)
    }
}

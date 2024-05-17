//
//  UserAppointmentsDTO.swift
//  BeautyScan
//
//  Created by Admin on 5/16/24.
//

import Foundation

struct UserAppointmentsDTO: Decodable {
    let date: String
    let doctorName: String
    
    enum CodingKeys: String, CodingKey {
        case date
        case doctorName = "doctor_name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        date = try values.decode(String.self, forKey: .date)
        doctorName = try values.decode(String.self, forKey: .doctorName)
    }
}

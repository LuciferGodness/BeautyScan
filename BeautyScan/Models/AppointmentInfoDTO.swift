//
//  AppointmentInfoDTO.swift
//  BeautyScan
//
//  Created by Admin on 5/6/24.
//

import Foundation

struct AppointmentInfoDTO: PFormEncoding {
    let appointmentId: Int
    
    func toFormData() -> [String: Any] {
        return [
            "appointmentId": appointmentId,
        ]
    }
}

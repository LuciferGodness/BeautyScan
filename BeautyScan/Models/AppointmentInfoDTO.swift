//
//  AppointmentInfoDTO.swift
//  BeautyScan
//
//  Created by Admin on 5/6/24.
//

import Foundation

struct AppointmentInfoDTO: PFormEncoding {
    let doctorId: Int
    let appointmentId: Int
    
    func toFormData() -> [String: Any] {
        return [
            "doctorId": doctorId,
            "appointmentId": appointmentId,
        ]
    }
}

//
//  UserAppointmentCell.swift
//  BeautyScan
//
//  Created by Admin on 5/16/24.
//

import UIKit

final class UserAppointmentCell: UITableViewCell {
    @IBOutlet private weak var appointmentDate: UILabel!
    @IBOutlet private weak var doctorsName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(model: UserAppointmentsDTO?) {
        appointmentDate.text = convertDate(dateString: model?.date ?? "")
        doctorsName.text = model?.doctorName ?? ""
    }
    
    private func convertDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

        var formattedDate = ""
        if let date = dateFormatter.date(from: dateString) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = "dd MMMM, HH:mm"
            formattedDate = outputDateFormatter.string(from: date)
        } else {
            print("Неверный формат даты")
        }
        return formattedDate
    }
}

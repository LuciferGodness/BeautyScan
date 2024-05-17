//
//  DoctorsSectionTypes.swift
//  BeautyScan
//
//  Created by Admin on 5/16/24.
//

import Foundation
import UIKit

enum Sections: Int {
    case userAppointments
    case doctors
    
    var rowHeight: CGFloat {
        switch self {
        case .userAppointments:
            return 60
        case .doctors:
            return 45
        }
    }
    
    func headerView() -> UIView {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        let titleLabel = UILabel()
        switch self {
        case .userAppointments:
            titleLabel.text = LocalizationKeys.myAppointments.localized()
        case .doctors:
            titleLabel.text = LocalizationKeys.doctorsSpecialty.localized()
        }
        titleLabel.textColor = AppColors.blackAsset.color
        titleLabel.font = UIFont.systemFont(ofSize: 21, weight: .light)
        titleLabel.textAlignment = .center
        headerView.addSubview(titleLabel)
        headerView.layer.cornerRadius = 10

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])

        return headerView
    }
}

//
//  DoctorMainInfoCell.swift
//  BeautyScan
//
//  Created by Admin on 4/11/24.
//

import UIKit

final class DoctorMainInfoCell: UITableViewCell {
    @IBOutlet private weak var doctorDescription: UITextView!
    @IBOutlet private weak var address: UILabel!
    @IBOutlet private weak var doctorName: UILabel!
    @IBOutlet private weak var price: UILabel!
    @IBOutlet private weak var experience: UILabel!
    @IBOutlet private weak var specialty: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = DesignConstants.cornerRadius
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        doctorDescription.textContainer.lineFragmentPadding = DesignConstants.zero
        doctorDescription.textContainerInset = .zero
    }
    
    func setup(model: DoctorInfoDTO?) {
        doctorName.text = model?.doctorName
        specialty.text = model?.specialty
        doctorDescription.text = model?.description
        experience.text = model?.experience.description
        price.text = model?.price.description
        address.text = model?.clinicAddress
    }
}

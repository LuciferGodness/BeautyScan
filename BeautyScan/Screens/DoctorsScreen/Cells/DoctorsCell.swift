//
//  DoctorsCell.swift
//  BeautyScan
//
//  Created by Admin on 5/16/24.
//

import UIKit

final class DoctorsCell: UITableViewCell {
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var specialty: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(model: DoctorsDTO?) {
        name.text = model?.name ?? ""
        specialty.text = model?.specialty ?? ""
    }
}

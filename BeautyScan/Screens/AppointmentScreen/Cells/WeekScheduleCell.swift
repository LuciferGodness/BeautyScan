//
//  WeekScheduleCell.swift
//  BeautyScan
//
//  Created by Admin on 4/11/24.
//

import UIKit

final class WeekScheduleCell: UITableViewCell {
    @IBOutlet weak var calendarView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        calendarView.layer.cornerRadius = DesignConstants.cornerRadius
    }
}

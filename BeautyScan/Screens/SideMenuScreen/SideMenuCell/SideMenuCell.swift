//
//  SideMenuCell.swift
//  BeautyScan
//
//  Created by admin on 08.02.2024.
//

import UIKit

final class SideMenuCell: UITableViewCell {
    @IBOutlet private weak var screenIcon: UIImageView!
    @IBOutlet private weak var screenName: UILabel!

    func setup(image: UIImage?, label: String?) {
        screenIcon.image = image
        screenName.text = label
    }
}

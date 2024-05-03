//
//  ProfileCell.swift
//  BeautyScan
//
//  Created by admin on 08.02.2024.
//

import UIKit

final class ProfileCell: UITableViewCell {
    @IBOutlet private weak var oilySkin: UILabel!
    @IBOutlet private weak var sensitiveSkin: UILabel!
    @IBOutlet private weak var pigmentedSkin: UILabel!
    @IBOutlet private weak var wrinkledSkin: UILabel!
    @IBOutlet private weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.layer.cornerRadius = DesignConstants.cornerRadius
    }
    
    func setup() {
        oilySkin.text = AppState.current.oilySkin ?? LocalizationKeys.undefined.localized()
        sensitiveSkin.text = AppState.current.resistentSkin ?? LocalizationKeys.undefined.localized()
        pigmentedSkin.text = AppState.current.pigmentedSkin ?? LocalizationKeys.undefined.localized()
        wrinkledSkin.text = AppState.current.wrinkledSkin ?? LocalizationKeys.undefined.localized()
    }
}

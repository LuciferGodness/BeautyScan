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
        //TODO: addConstants
        backView.layer.cornerRadius = 10
    }
    
    func setup() {
        //TODO: addLocalizable
        oilySkin.text = AppState.current.oilySkin ?? "Undefined"
        sensitiveSkin.text = AppState.current.resistentSkin ?? "Undefined"
        pigmentedSkin.text = AppState.current.pigmentedSkin ?? "Undefined"
        wrinkledSkin.text = AppState.current.wrinkledSkin ?? "Undefined"
    }
}

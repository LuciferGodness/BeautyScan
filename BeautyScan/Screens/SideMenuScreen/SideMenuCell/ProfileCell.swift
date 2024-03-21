//
//  ProfileCell.swift
//  BeautyScan
//
//  Created by admin on 08.02.2024.
//

import UIKit

final class ProfileCell: UITableViewCell {
    @IBOutlet private weak var rightEyelid: UILabel!
    @IBOutlet private weak var acne: UILabel!
    @IBOutlet private weak var leftEyelid: UILabel!
    @IBOutlet private weak var blackhead: UILabel!
    @IBOutlet private weak var backView: UIView!
    @IBOutlet private weak var skinType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //TODO: addConstants
        backView.layer.cornerRadius = 10
    }
    
    func setup() {
        //TODO: addLocalizable
        skinType.text = AppState.current.skinType ?? "Undefined"
        rightEyelid.text = AppState.current.rightEyelid ?? "Undefined"
        leftEyelid.text = AppState.current.leftEyelid ?? "Undefined"
        acne.text = AppState.current.acne ?? "Undefined"
        blackhead.text = AppState.current.blackhead ?? "Undefined"
    }
}

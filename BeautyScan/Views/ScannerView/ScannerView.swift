//
//  ImageCell.swift
//  BeautyScan
//
//  Created by Admin on 4/5/24.
//

import UIKit

final class ScannerView: UIView {
    @IBOutlet private weak var bottomView: UIView!
    @IBOutlet private weak var scannerFrame: UIImageView!
    @IBOutlet weak var scannerHint: UILabel!
    private var action: (() -> Void)?
    
    override func awakeFromNib() {
        bottomView.layer.cornerRadius = DesignConstants.cornerRadius
        scannerFrame.image = AppAssets.scannerFrame.image?.withTintColor(AppColors.whiteAsset.color ?? .white)
        scannerHint.layer.cornerRadius = DesignConstants.cornerRadius
        scannerHint.clipsToBounds = true
        scannerHint.text = LocalizationKeys.scannerHint.localized()
    }
    
    func setup(_ action: @escaping () -> Void) {
        self.action = action
    }
    
    @IBAction private func takePhoto() {
        guard let action = self.action else { return }
        action()
    }
}

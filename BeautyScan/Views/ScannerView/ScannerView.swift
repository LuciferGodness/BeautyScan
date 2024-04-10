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
        bottomView.layer.cornerRadius = 10
        scannerFrame.image = AppAssets.scannerFrame.image?.withTintColor(AppColors.whiteAsset.color ?? .white)
        scannerHint.layer.cornerRadius = 10
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

//
//  UIActivityIndicator + Extension.swift
//  BeautyScan
//
//  Created by admin on 11.12.2023.
//

import UIKit

extension UIActivityIndicatorView {
    func startWithAppearAnimation() {
        startAnimating()
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1
        }
    }
    
    func endWithDisappearAnimation() {
        UIView.animate(withDuration: 0.2) {
            self.alpha = 0
        } completion: { _ in
            self.stopAnimating()
        }
    }
}

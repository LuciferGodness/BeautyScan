//
//  RegistrationVC.swift
//  BeautyScan
//
//  Created by admin on 16.12.2023.
//

import UIKit

protocol PRegistrationVC: PBaseVC {
    func openHome()
}

final class RegistrationVC: BaseVC, PRegistrationVC {
    var vm: PRegistrationVM?
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var passwordField: UITextField!
    @IBOutlet private weak var rotatingLabel: UILabel!
    @IBOutlet private weak var phoneNumber: UITextField!
    
    private let textArray = [LocalizationKeys.firstRegText.localized(), LocalizationKeys.secondRegText.localized(),  LocalizationKeys.thirdRegText.localized(), LocalizationKeys.fourthRegText.localized(), LocalizationKeys.fifthRegText.localized(), LocalizationKeys.sixthRegText.localized()]
    private var timer: Timer?
    
    override var isNavigationBarLeftButton: Bool {
        false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginButton.layer.cornerRadius = DesignConstants.registrationCornerRadius
        loginButton.setImage(AppAssets.next.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        loginButton.tintColor = AppColors.whiteAsset.color
        phoneNumber.layer.cornerRadius = DesignConstants.registrationCornerRadius
        
        timer = Timer.scheduledTimer(timeInterval: DesignConstants.timeInterval,
                                     target: self,
                                     selector: #selector(updateText),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    @objc private func updateText() {
        let randomIndex = Int(arc4random_uniform(UInt32(textArray.count)))
        UIView.animate(withDuration: 0.75, animations: {
                    self.rotatingLabel.alpha = 0.0
        }) { (_) in
            self.rotatingLabel.text = self.textArray[randomIndex]

            UIView.animate(withDuration: 0.5, animations: {
                self.rotatingLabel.alpha = 1.0
            })
        }
    }
    
    @IBAction private func getCode() {
        vm?.requestCode(phone: phoneNumber.text)
    }
    
    @IBAction private func loginAction() {
        vm?.verifyCode(phoneNumber: phoneNumber.text, code: passwordField.text)
    }
    // MARK: - Navigation

    func openHome() {
        navigationController?.pushViewController(HomeAssembler.assemble(), animated: true)
    }
}

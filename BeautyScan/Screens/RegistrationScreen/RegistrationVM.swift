//
//  RegistrationVM.swift
//  BeautyScan
//
//  Created by admin on 16.12.2023.
//

import Foundation
import RxSwift

protocol PRegistrationVM {
    func requestCode(phone: String?)
    func verifyCode(phoneNumber: String?, code: String?)
}

final class RegistrationVM: PRegistrationVM {
    var apiService: PApiServices?
    weak var view: PRegistrationVC?
    private let disposeBag = DisposeBag()
    
    func requestCode(phone: String?) {
        apiService?.getCodeForLogin(phone: phone)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { _ in
            }, onFailure: { error in
                self.view?.showAlert(message: error.localizedDescription, nil,
                                     title: LocalizationKeys.error.localized(),
                                     okTitle: LocalizationKeys.ok.localized())
            }).disposed(by: disposeBag)
    }
    
    func verifyCode(phoneNumber: String?, code: String?) {
        apiService?.verifyLoginCode(phoneNumber: phoneNumber ?? "", code: code ?? "")
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { response in
                AppState.current.accessToken = response.token
                self.view?.openHome()
            }, onFailure: { error in
                self.view?.showAlert(message: error.localizedDescription, nil,
                                     title: LocalizationKeys.error.localized(),
                                     okTitle: LocalizationKeys.ok.localized())
            }).disposed(by: disposeBag)
    }
}

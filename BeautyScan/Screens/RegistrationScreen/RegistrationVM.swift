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
    var apiService: ApiServices?
    weak var view: PRegistrationVC?
    private let disposeBag = DisposeBag()
    
    func requestCode(phone: String?) {
        apiService?.getCodeForLogin(phone: phone)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { response in
                print(response)
            }, onFailure: { error in
                self.view?.showAlert(message: error.localizedDescription, nil, title: "Error", okTitle: "OK")
            }).disposed(by: disposeBag)
    }
    
    func verifyCode(phoneNumber: String?, code: String?) {
        apiService?.verifyLoginCode(phoneNumber: phoneNumber ?? "", code: code ?? "")
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { response in
                //TODO: addLocalizable
                guard let token = response.token else {
                    self.view?.showAlert(message: "Token not received", nil, title: "Error", okTitle: "OK")
                    return
                }
                self.view?.openHome()
            }, onFailure: { error in
                self.view?.showAlert(message: error.localizedDescription, nil, title: "Error", okTitle: "OK")
            }).disposed(by: disposeBag)
    }
}
//
//  DoctorsVM.swift
//  BeautyScan
//
//  Created by Admin on 5/16/24.
//

import Foundation
import RxSwift

protocol PDoctorsVM {
    func getData()
    var appointmentModel: [UserAppointmentsDTO] { get }
    var doctorsModel: [DoctorsDTO] { get }
}

final class DoctorsVM: PDoctorsVM {
    var apiService: PApiServices?
    private let disposeBag = DisposeBag()
    weak var view: PDoctorsVC?
    var appointmentModel: [UserAppointmentsDTO] = []
    var doctorsModel: [DoctorsDTO] = []
    
    func getData() {
        Single.zip((apiService?.getUserAppointments())!, (apiService?.getAllDoctors())!)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { appointment, doctors in
                self.appointmentModel = appointment
                self.doctorsModel = doctors
                self.view?.reloadTable()
            }, onFailure: { error in
                self.view?.showAlert(message: error.localizedDescription, nil,
                                     title: LocalizationKeys.error.localized(),
                                     okTitle: LocalizationKeys.ok.localized())
            }).disposed(by: disposeBag)
    }
}

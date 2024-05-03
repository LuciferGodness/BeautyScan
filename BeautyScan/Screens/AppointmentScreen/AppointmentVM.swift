//
//  AppointmentVM.swift
//  BeautyScan
//
//  Created by Admin on 4/11/24.
//

import Foundation
import RxSwift

protocol PAppointmentVM {
    func getAppointment()
    var model: DoctorInfoDTO? { get }
}

final class AppointmentVM: PAppointmentVM {
    var apiService: ApiServices?
    private let disposeBag = DisposeBag()
    weak var view: PAppointmentVC?
    var model: DoctorInfoDTO?
    
    func getAppointment() {
        apiService?.getDoctorInfo(doctorId: 1)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { data in
                self.model = data
                self.view?.reloadTable()
            }, onFailure: { error in
                
            }).disposed(by: disposeBag)
    }
}

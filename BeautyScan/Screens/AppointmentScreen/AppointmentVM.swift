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
    func bookAppointment(appointmentId: Int)
    var model: DoctorInfoDTO? { get }
}

final class AppointmentVM: PAppointmentVM {
    var apiService: PApiServices?
    private let disposeBag = DisposeBag()
    weak var view: PAppointmentVC?
    var model: DoctorInfoDTO?
    private var id: Int = 1
    
    init(id: Int) {
        self.id = id
    }
    
    func getAppointment() {
        apiService?.getDoctorInfo(doctorId: id)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { data in
                self.model = data
                self.view?.reloadTable()
            }, onFailure: { error in
                
            }).disposed(by: disposeBag)
    }
    
    func bookAppointment(appointmentId: Int) {
        apiService?.bookAppointment(appointmentId: appointmentId)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { answer in
                self.view?.showAlert(message: answer.message, {
                    self.view?.returnOnPreviousScreen()
                }, title: "Info", okTitle: "Ok")
            }, onFailure: { error in
                self.view?.showAlert(message: error.localizedDescription, nil, title: "Error", okTitle: "Ok")
            }).disposed(by: disposeBag)
    }
}

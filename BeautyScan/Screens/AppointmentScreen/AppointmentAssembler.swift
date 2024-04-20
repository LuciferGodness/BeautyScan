//
//  AppointmentAssembler.swift
//  BeautyScan
//
//  Created by Admin on 4/11/24.
//

import Foundation

enum AppointmentAssembler {
    static func assemble() -> AppointmentVC {
        let apiServices = ApiServices()
        let view = AppointmentVC()
        let viewModel = AppointmentVM()
        
        view.viewModel = viewModel
        viewModel.view = view
        viewModel.apiService = apiServices
        
        return view
    }
}

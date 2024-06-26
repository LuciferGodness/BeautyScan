//
//  AppointmentAssembler.swift
//  BeautyScan
//
//  Created by Admin on 4/11/24.
//

import Foundation

enum AppointmentAssembler {
    static func assemble(id: Int) -> AppointmentVC {
        let apiServices = ApiServices()
        let view = AppointmentVC()
        let viewModel = AppointmentVM(id: id)
        
        view.viewModel = viewModel
        viewModel.view = view
        viewModel.apiService = apiServices
        
        return view
    }
}

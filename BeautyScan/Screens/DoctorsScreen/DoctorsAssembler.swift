//
//  DoctorsAssembler.swift
//  BeautyScan
//
//  Created by Admin on 5/16/24.
//

import Foundation

enum DoctorsAssembler {
    static func assemble() -> DoctorsVC {
        let apiServices = ApiServices()
        let view = DoctorsVC()
        let viewModel = DoctorsVM()
        
        view.viewModel = viewModel
        viewModel.view = view
        viewModel.apiService = apiServices
        
        return view
    }
}

//
//  RegistrationAssembler.swift
//  BeautyScan
//
//  Created by admin on 16.12.2023.
//

import Foundation

struct RegistrationAssembler {
    static func assemble() -> RegistrationVC {
        let apiServices = ApiServices()
        let regVC = RegistrationVC()
        let regVM = RegistrationVM()
        
        regVC.vm = regVM
        regVM.view = regVC
        regVM.apiService = apiServices
        
        return regVC
    }
}

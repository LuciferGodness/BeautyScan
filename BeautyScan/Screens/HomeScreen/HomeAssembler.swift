//
//  HomeAssembler.swift
//  BeautyScan
//
//  Created by admin on 09.11.2023.
//

import Foundation

struct HomeAssembler {
    static func assemble() -> HomeVC {
        let apiServices = ApiServices()
        let homeVC = HomeVC()
        let homeVM = HomeVM()
        
        homeVC.vm = homeVM
        homeVM.view = homeVC
        homeVM.apiService = apiServices
        
        return homeVC
    }
}

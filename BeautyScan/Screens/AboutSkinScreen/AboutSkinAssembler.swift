//
//  TestAssembler.swift
//  BeautyScan
//
//  Created by admin on 19.01.2024.
//

import Foundation

struct AboutSkinAssembler {
    static func assemble() -> AboutSkinVC {
        let testVC = AboutSkinVC()
        let apiServices = ApiServices()
        let testVM = AboutSkinVM()
        
        testVC.vm = testVM
        testVM.view = testVC
        testVM.apiService = apiServices
        
        return testVC
    }
}

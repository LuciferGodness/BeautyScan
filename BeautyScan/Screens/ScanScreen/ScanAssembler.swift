//
//  ScanAssembler.swift
//  BeautyScan
//
//  Created by admin on 03.12.2023.
//

import Foundation

struct ScanAssembler {
    static func assemble() -> ScanVC {
        let scanVC = ScanVC()
        let scanVM = ScanVM()
        
        scanVM.view = scanVC
        scanVC.vm = scanVM
        
        return scanVC
    }
}

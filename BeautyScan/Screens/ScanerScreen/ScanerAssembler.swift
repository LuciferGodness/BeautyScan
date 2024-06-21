//
//  ScanerAssembler.swift
//  BeautyScan
//
//  Created by Admin on 3/16/24.
//

import Foundation

enum ScanerAssembler {
    static func assemble(delegate: ScanerVCDelegate) -> ScanerVC {
        let view = ScanerVC()
        let viewModel = ScanerVM()
        
        view.scannerViewModel = viewModel
        view.delegate = delegate
        view.modalPresentationStyle = .popover
        viewModel.vc = view
        
        return view
    }
}

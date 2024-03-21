//
//  TestVM.swift
//  BeautyScan
//
//  Created by admin on 19.01.2024.
//

import Foundation
import RxSwift
import OpenAISwift

protocol PAboutSkinVM {
    
}

final class AboutSkinVM: PAboutSkinVM {
    var apiService: ApiServices?
    weak var view: PAboutSkinVC?
    private let disposeBag = DisposeBag()
    
    private func rememberData(response: SkinAnalizeDTO) {
        AppState.current.skinType = response.getSkinTypeDescription()
        AppState.current.rightEyelid = response.getEyelidsDescription(eyelidType: .rightEyelid)
        AppState.current.acne = response.getTestResultsDescription(testType:{ $0.acne.value })
        AppState.current.blackhead = response.getTestResultsDescription(testType:{ $0.blackhead.value })
        AppState.current.leftEyelid = response.getEyelidsDescription(eyelidType: .leftEyelid)
    }
}

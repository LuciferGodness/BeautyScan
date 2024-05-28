//
//  HomeVM.swift
//  BeautyScan
//
//  Created by admin on 09.11.2023.
//

import Foundation
import RxSwift

protocol PHomeVM {
    var model: HomeDTO? { get }
    var searchData: SearchProductDTO? { get }
    func getData()
}

final class HomeVM: PHomeVM {
    var apiService: PApiServices?
    weak var view: PHomeVC?
    private let disposeBag = DisposeBag()
    var model: HomeDTO?
    var searchData: SearchProductDTO?
    
    func getData() {
        apiService?.getDataForHome()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { data in
                self.model = data
                for product in data.hits {
                    self.getSearchProduct(productName: product.name)
                }
                self.view?.reloadView()
            }, onFailure: { error in
                self.view?.showAlert(message: error.localizedDescription, nil,
                                     title: LocalizationKeys.error.localized(),
                                     okTitle: LocalizationKeys.ok.localized())
            }).disposed(by: disposeBag)
    }
    
    private func getSearchProduct(productName: String) {
        apiService?.searchProduct(producrName: productName)
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { searchData in
                self.searchData = searchData
                self.view?.reloadView()
            }, onFailure: { _ in
            }).disposed(by: disposeBag)
    }
}

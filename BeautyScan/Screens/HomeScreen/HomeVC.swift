//
//  HomeVC.swift
//  BeautyScan
//
//  Created by admin on 09.11.2023.
//

import UIKit

protocol PHomeVC: PBaseVC {
    func reloadView()
}

final class HomeVC: BaseVC, PHomeVC {
    @IBOutlet private weak var tableView: UITableView!
    var vm: PHomeVM?
    private var searchDataItem: [Int: Item] = [:]
    private let searchField = UITextField(frame: CGRect(x: 0, y: 0, width: 270, height: 48))

    override func viewDidLoad() {
        super.viewDidLoad()
        startLoading()
        vm?.getData()
        setupUI()
    }
    
    private func setupUI() {
        setupTableView()
        setupTextField()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(ofType: HomeTableCell.self)
    }
    
    private func setupTextField() {
        searchField.delegate = self
        searchField.textColor = AppColors.blackAsset.color
        searchField.placeholder = LocalizationKeys.productLink.localized()
        navigationItem.titleView = searchField
    }
    
    func reloadView() {
        endLoading()
        tableView.reloadData()
    }
    
    // MARK: - Navigation
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        353
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        vm?.model?.hits.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return homeTableCell(for: indexPath, tableView)
    }
    
    private func homeTableCell(for indexPath: IndexPath, _ tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(ofType: HomeTableCell.self),
              let model = vm?.model else {
            return UITableViewCell()
        }
        
        let product = model.hits[indexPath.row]
        updateSearchDataItem(for: indexPath.row, product: product)
        
        cell.setup(product: product, searchData: searchDataItem[indexPath.row])
        return cell
    }
    
    private func updateSearchDataItem(for index: Int, product: Product) {
        guard let searchData = vm?.searchData, let searchItems = searchData.items else {
            return
        }
        
        for (value, title) in searchData.queries.request.enumerated() {
            if title.searchTerms == product.name {
                searchDataItem[index] = searchItems[value]
            }
        }
    }
}

extension HomeVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


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
    private var searchTableView: UITableView!
    private var filteredProducts: [ProductSearch] = []
    private var tableReloadForSearch: Bool = false
    private var resultForSearch: ProductSearch?

    override func viewDidLoad() {
        super.viewDidLoad()
        startLoading()
        vm?.getData()
        setupUI()
    }
    
    private func setupUI() {
        setupTableView()
        setupTextField()
        setupSearchTableView()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(ofType: HomeTableCell.self)
    }
    
    private func setupSearchTableView() {
        searchTableView = UITableView()
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.translatesAutoresizingMaskIntoConstraints = false
        searchTableView.isHidden = true
        searchTableView.backgroundColor = AppColors.whiteAsset.color
        searchTableView.separatorStyle = .none
        searchTableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        
        view.addSubview(searchTableView)
        setupTableViewConstraints()
    }
    
    private func setupTableViewConstraints() {
        //TODO: toConstants
        NSLayoutConstraint.activate([
            searchTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            searchTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
        ])
    }
    
    private func setupTextField() {
        //TODO: addLocalizable
        searchField.delegate = self
        searchField.textColor = AppColors.blackAsset.color
        searchField.placeholder = "Поиск..."
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
        (tableView != searchTableView) ? 353 : 45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableReloadForSearch {
            1
        } else {
            (tableView == self.tableView) ? vm?.model?.hits.count ?? 0 : filteredProducts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView != searchTableView {
            return homeTableCell(for: indexPath, tableView)
        } else {
            return searchTableViewCell(for: indexPath, tableView)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == searchTableView {
            handleSearchTableViewSelection(at: indexPath.row)
        }
    }
    
    private func homeTableCell(for indexPath: IndexPath, _ tableView: UITableView) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(ofType: HomeTableCell.self),
              let model = vm?.model else {
            return UITableViewCell()
        }
        
        let product = model.hits[indexPath.row]
        updateSearchDataItem(for: indexPath.row, product: product)
        
        if tableReloadForSearch {
            cell.setupForProduct(result: resultForSearch)
        } else {
            cell.setup(product: product, searchData: searchDataItem[indexPath.row])
        }
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
    
    private func searchTableViewCell(for indexPath: IndexPath, _ tableView: UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath)
        cell.backgroundColor = AppColors.whiteAsset.color
        cell.textLabel?.textColor = AppColors.blackAsset.color
        
        let result = filteredProducts[indexPath.row]
        cell.textLabel?.text = result.name
        
        return cell
    }
    
    private func handleSearchTableViewSelection(at index: Int) {
        tableReloadForSearch.toggle()
        searchTableView.isHidden = true
        resultForSearch = filteredProducts[index]
        tableView.reloadData()
    }
}

extension HomeVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        searchProduct(inputQueue: textField.text ?? "")
        reloadSearchTableView()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let searchText = textField.text ?? ""
        
        if searchText.isEmpty {
            hideSearchTableView()
        } else {
            searchProduct(inputQueue: searchText)
            reloadSearchTableView()
        }
    }
    
    private func hideSearchTableView() {
        searchTableView.isHidden = true
    }
    
    private func showSearchTableView() {
        searchTableView.isHidden = false
    }
    
    private func reloadSearchTableView() {
        searchTableView.reloadData()
    }
    
    private func searchProduct(inputQueue: String) {
        DispatchQueue.global().async { [weak self] in
            self?.fetchSearchResults(inputQueue: inputQueue)
        }
    }
    
    private func fetchSearchResults(inputQueue: String) {
        vm?.getUserSearchProducts(productName: inputQueue)
        filteredProducts = vm?.searchModel?.products ?? []
        DispatchQueue.main.async { [weak self] in
            self?.handleSearchResults()
        }
    }
    
    private func handleSearchResults() {
        if !filteredProducts.isEmpty {
            showSearchTableView()
        } else {
            hideSearchTableView()
        }
        reloadSearchTableView()
    }
}


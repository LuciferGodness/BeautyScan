//
//  UITableView + Extension.swift
//  BeautyScan
//
//  Created by admin on 18.11.2023.

import UIKit

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableView {
    func registerCell(ofType type: UITableViewCell.Type) {
        register(UINib(nibName: type.identifier, bundle: nil), forCellReuseIdentifier: type.identifier)
    }
    
    func dequeueCell<T>(ofType type: T.Type) -> T? where T: UITableViewCell {
        dequeueReusableCell(withIdentifier: T.identifier) as? T
    }
}

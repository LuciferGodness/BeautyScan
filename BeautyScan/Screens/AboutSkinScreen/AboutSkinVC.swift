//
//  TestVC.swift
//  BeautyScan
//
//  Created by admin on 19.01.2024.
//

import UIKit

protocol PAboutSkinVC: PBaseVC {
    func showResult(message: String?)
}

final class AboutSkinVC: BaseVC, PAboutSkinVC {
    @IBOutlet private weak var tableView: UITableView!
    var vm: PAboutSkinVM?
    
    override var navigationBarTitle: String? {
        "About Skin"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func learnSkinType() {
        startLoading()
    }
    
    func showResult(message: String?) {
        //resultLabel.text = message
    }
    
    // MARK: - Navigation

}

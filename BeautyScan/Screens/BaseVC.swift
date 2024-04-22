//
//  BaseVC.swift
//  BeautyScan
//
//  Created by admin on 09.11.2023.
//

import UIKit
import SideMenu

protocol PBaseVC: AnyObject {
    func startLoading()
    func endLoading()
    func showAlert(message: String?, _ completion: (() -> Void)?, title: String?, okTitle: String)
}

class BaseVC: UIViewController, PBaseVC {
    
    private let loadingIndicator = UIActivityIndicatorView()
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        .portrait
    }
    
    var navigationBarTitle: String? { nil }
    
    var isNavigationBarLeftButton: Bool {
        true
    }
    
    var isNavigationBarHidden: Bool {
        false
    }
    
    private func setupNavigationBar() {
        title = navigationBarTitle
        navigationController?.navigationBar.barTintColor = AppColors.whiteAsset.color
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : AppColors.blackAsset.color ?? .black]
        if isNavigationBarLeftButton {
            setupMenuButton()
        }
    }
    
    private func setupMenuButton() {
        let menuButton = UIButton(type: .custom)
        menuButton.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
        menuButton.setImage(AppAssets.menuImage.image?.withTintColor(AppColors.grayAsset.color ?? .black), for: .normal)
        menuButton.imageView?.contentMode = .scaleAspectFit
        
        let menuBarButton = UIBarButtonItem(customView: menuButton)
        self.navigationItem.leftBarButtonItem = menuBarButton
    }
    
    @objc
    private func openScanScreen() {
        navigationController?.pushViewController(ScanAssembler.assemble(), animated: true)
    }
    
    func startLoading() {
        loadingIndicator.color = .black
        loadingIndicator.startWithAppearAnimation()
    }
    
    func endLoading() {
        loadingIndicator.endWithDisappearAnimation()
    }
    
    func showAlert(message: String?, _ completion: (() -> Void)?, title: String?, okTitle: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: okTitle, style: .default) {_ in
            completion?()
        })
        
        present(alert, animated: true)
    }

    override func viewDidLoad() {
        setupLoadingIndicator()
        super.viewDidLoad()
        setupNavigationBar()
        setupMenu()
        navigationController?.setNavigationBarHidden(isNavigationBarHidden, animated: false)
    }
    
    private func setupMenu() {
        let menu = SideMenuNavigationController(rootViewController: SideMenuAssembler.assemble())
        menu.presentationStyle = .menuSlideIn
        menu.menuWidth = 320

        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    
    private func setupLoadingIndicator() {
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator)
        view.bringSubviewToFront(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0)
        ])
    }

    // MARK: - Navigation
    
    @objc func openMenu() {
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
}

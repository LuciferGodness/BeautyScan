//
//  SideMenuVC.swift
//  BeautyScan
//
//  Created by admin on 18.01.2024.
//

import UIKit
import SideMenu

final class SideMenuVC: BaseVC {
    @IBOutlet weak var uiTableView: UITableView!
    private var sections: [Section] = []
    
    override var isNavigationBarHidden: Bool {
        true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSections()
        configureBackgroundEffects()
        setupBackground()
    }
    
    private func setupSections() {
        sections = [
            .profile,
            .mainOptions([.home, .scanProduct, .learnSkinType]),
            .additionalOptions([.requestSupport, .logout])
        ]
    }
    
    private func setupTableView() {
        uiTableView.dataSource = self
        uiTableView.delegate = self
        uiTableView.registerCell(ofType: ProfileCell.self)
        uiTableView.registerCell(ofType: SideMenuCell.self)
    }
    
    private func setupBackground() {
        let backgroundImage = AppAssets.menuBackground.image
        let backgroundImageView = UIImageView(image: backgroundImage)

        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = view.bounds

        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateMenu()
    }
    
    private func updateMenu() {
        uiTableView.reloadData()
    }
    
    private func configureBackgroundEffects() {
        SideMenuManager.default.leftMenuNavigationController?.blurEffectStyle = .systemUltraThinMaterialLight
    }
    
    // MARK: - Navigation
}

extension SideMenuVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].numberOfRows
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch sections[section] {
        case .mainOptions:
            return DesignConstants.registrationCornerRadius
        case .additionalOptions:
            return DesignConstants.sideMenuCell
        case .profile:
            return DesignConstants.zero
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueCell(ofType: ProfileCell.self) else { return UITableViewCell() }
            cell.setup()
            
            return cell
        } else {
            let item = sections[indexPath.section].items[indexPath.row]
            guard let cell = tableView.dequeueCell(ofType: SideMenuCell.self) else { return UITableViewCell() }
            cell.setup(image: item.image, label: item.label)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            switch indexPath.row {
            case 0:
                navigateToViewController(HomeAssembler.assemble())
            case 1:
                navigateToViewController(ScanAssembler.assemble())
            case 2:
                navigateToViewController(AboutSkinAssembler.assemble())
            default:
                break
            }
        } else if indexPath.section == 2 {
            switch indexPath.row {
            case 0:
                break
            case 1:
                AppState.current.logout()
            default:
                break
            }
        }
    }
    
    private func navigateToViewController(_ viewController: UIViewController) {
        guard let navigationController = self.navigationController as? SideMenuNavigationController,
              let presentingNav = navigationController.presentingViewController as? UINavigationController else {
            return
        }
        
        presentingNav.setViewControllers([viewController], animated: false)
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        sections[indexPath.section].rowHeight
    }
}

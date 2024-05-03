//
//  TestVC.swift
//  BeautyScan
//
//  Created by admin on 19.01.2024.
//

import UIKit
import SideMenu

protocol PAboutSkinVC: PBaseVC {
    func displayQuestion(_ question: String, options: [String])
    func openSideMenu()
}

final class AboutSkinVC: BaseVC, PAboutSkinVC {
    @IBOutlet private weak var testView: UIView!
    @IBOutlet private weak var questionText: UILabel!
    @IBOutlet private weak var optionOne: UIButton!
    @IBOutlet private weak var optionTwo: UIButton!
    @IBOutlet private weak var optionThree: UIButton!
    @IBOutlet private weak var optionFour: UIButton!
    @IBOutlet private weak var optionFive: UIButton!
    @IBOutlet private weak var progressView: UIProgressView!
    @IBOutlet private weak var countLabel: UILabel!
    private var optionButtons: [UIButton] = []
    
    var vm: PAboutSkinVM?
    
    override var navigationBarTitle: String? {
        LocalizationKeys.aboutSkinScreen.localized()
    }
    
    override func viewDidLoad() {
        optionButtons = [optionOne, optionTwo, optionThree, optionFour, optionFive]
        vm?.getQuestions()
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        testView.layer.cornerRadius = DesignConstants.cornerRadius
        optionButtons.forEach { $0.titleLabel?.numberOfLines = 0 }
    }
    
    @IBAction private func learnSkinType() {
        startLoading()
    }
    
    func displayQuestion(_ question: String, options: [String]) {
        questionText.text = question
        for (index, button) in optionButtons.enumerated() {
            if index < options.count {
                button.setTitle(options[index], for: .normal)
                button.isHidden = false
            } else {
                button.isHidden = true
            }
        }
        countLabel.text = "\(vm?.currentQuestionIndex ?? 0) из \(vm?.allQuestions ?? 0)"
    }

    @IBAction func optionSelected(_ sender: UIButton) {
        vm?.showNextQuestion(sender: sender.tag)
        countLabel.text = "\(vm?.currentQuestionIndex ?? 0) из \(vm?.allQuestions ?? 0)"
        progressView.setProgress(vm?.progressValue ?? 0, animated: true)
    }
    // MARK: - Navigation
    
    @IBAction func doctorAppointment() {
        navigationController?.pushViewController(AppointmentAssembler.assemble(), animated: true)
    }
    
    func openSideMenu() {
        present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
    }
}

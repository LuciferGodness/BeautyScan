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
    
    var vm: PAboutSkinVM?
    
    override var navigationBarTitle: String? {
        "About Skin"
    }
    
    override func viewDidLoad() {
        vm?.getQuestions()
        super.viewDidLoad()
        optionOne.titleLabel?.numberOfLines = 0
        optionTwo.titleLabel?.numberOfLines = 0
        optionThree.titleLabel?.numberOfLines = 0
        optionFour.titleLabel?.numberOfLines = 0
        optionFive.titleLabel?.numberOfLines = 0
        testView.layer.cornerRadius = 10
    }
    
    @IBAction private func learnSkinType() {
        startLoading()
    }
    
    func displayQuestion(_ question: String, options: [String]) {
        questionText.text = question
        optionOne.setTitle(options[0], for: .normal)
        optionTwo.setTitle(options[1], for: .normal)
        optionThree.setTitle(options[2], for: .normal)
        optionFour.setTitle(options[3], for: .normal)
        if options.endIndex == 5 {
            optionFive.setTitle(options[4], for: .normal)
            optionFive.isHidden = false
        } else {
            optionFive.isHidden = true
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

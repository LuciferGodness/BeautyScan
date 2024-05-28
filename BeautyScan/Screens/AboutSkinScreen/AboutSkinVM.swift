//
//  TestVM.swift
//  BeautyScan
//
//  Created by admin on 19.01.2024.
//

import Foundation
import RxSwift

struct QuestionsWithOptions {
    let question: String
    let options: [String]
    let id: Int
}

protocol PAboutSkinVM {
    func getQuestions()
    func showNextQuestion(sender: Int)
    var progressValue: Float { get }
    var currentQuestionIndex: Int { get }
    var allQuestions: Int { get }
}

final class AboutSkinVM: PAboutSkinVM {
    var apiService: PApiServices?
    weak var view: PAboutSkinVC?
    private let disposeBag = DisposeBag()
    private var skinTypeScore: Double = 0
    private var currentTestPart: Int = 1
    private var questionsWithOptions: [QuestionsWithOptions]?
    var progressValue: Float = 0
    var currentQuestionIndex = 0
    var allQuestions: Int = 0
    
    func getQuestions() {
        apiService?.getQuestions()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { questions in
                self.questionsWithOptions = questions.map { .init(question: $0.question, options: $0.options, id: $0.id) }
                self.allQuestions = self.questionsWithOptions?.count ?? 0
                self.showNextQuestion(sender: 0)
            }, onFailure: { error in
            }).disposed(by: disposeBag)
    }
    
    func showNextQuestion(sender: Int) {
        updateScore(sender)

        if let questionsWithOptions = questionsWithOptions, currentQuestionIndex < questionsWithOptions.count {
            let nextQuestion = questionsWithOptions[currentQuestionIndex]
            if nextQuestion.id != currentTestPart {
                showTestResult(for: SkinTestPart(rawValue: currentTestPart) ?? .oily)
                currentTestPart = nextQuestion.id
                skinTypeScore = 0
            }
            progressValue += 1 / Float(questionsWithOptions.count)
            view?.displayQuestion(nextQuestion.question, options: nextQuestion.options)
        } else {
            showTestResult(for: .wrinkled)
            view?.showAlert(message: LocalizationKeys.skinType.localized(), {
                self.view?.openSideMenu()
            },
                            title: LocalizationKeys.yourType.localized(),
                            okTitle: LocalizationKeys.ok.localized())
        }
        currentQuestionIndex += 1
    }
    
    private func updateScore(_ sender: Int) {
        let scoreToAdd = sender == 5 ? Double(sender) / 2 : Double(sender)
        skinTypeScore += scoreToAdd
    }
    
    private func showTestResult(for part: SkinTestPart) {
        let result = part.calculateTestResult(for: skinTypeScore)
        
        switch part {
        case .oily:
            AppState.current.oilySkin = result
        case .resistent:
            AppState.current.resistentSkin = result
        case .pigmented:
            AppState.current.pigmentedSkin = result
        case .wrinkled:
            AppState.current.wrinkledSkin = result
        }
    }
}

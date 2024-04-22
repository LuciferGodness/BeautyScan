//
//  TestVM.swift
//  BeautyScan
//
//  Created by admin on 19.01.2024.
//

import Foundation
import RxSwift
import OpenAISwift

enum SkinTestPart: Int {
    case oily = 1
    case resistent
    case pigmented
    case wrinkled

    func calculateTestResult(for score: Double) -> String {
        switch self {
        case .oily:
            switch score {
            case 34...44:
                return "Очень жирная"
            case 27...33:
                return "Немного жирная"
            case 17...26:
                return "Немного сухая"
            case 11...16:
                return "Очень сухая"
            default:
                return "Undefined"
            }
        case .resistent:
            switch score {
            case 34...72:
                return "Очень чувствительная"
            case 20...33:
                return "Частично чувствительная"
            case 25...29:
                return "Более-менее резистентная"
            case 17...24:
                return "Очень резистентная"
            default:
                return "Undefined"
            }
        case .pigmented:
            switch score {
            case 29...52:
                return "Пигментированная"
            case 13...28:
                return "Непигментированная"
            default:
                return "Undefined"
            }
        case .wrinkled:
            switch score {
            case 20...40:
                return "Упругая"
            case 41...85:
                return "Морщинистая"
            default:
                return "Undefined"
            }
        }
    }
}

protocol PAboutSkinVM {
    func getQuestions()
    func showNextQuestion(sender: Int)
    var progressValue: Float { get }
    var currentQuestionIndex: Int { get }
    var allQuestions: Int { get }
}

final class AboutSkinVM: PAboutSkinVM {
    var apiService: ApiServices?
    weak var view: PAboutSkinVC?
    private let disposeBag = DisposeBag()
    private var skinTypeScore: Double = 0
    private var currentTestPart: Int = 1
    private var questionsWithOptions: [(String, [String], Int)]?
    var progressValue: Float = 0
    var currentQuestionIndex = 0
    var allQuestions: Int = 0
    
    func getQuestions() {
        apiService?.getQuestions()
            .observe(on: MainScheduler.instance)
            .subscribe(onSuccess: { questions in
                self.questionsWithOptions = questions.map { ($0.question, $0.options, $0.id) }
                self.allQuestions = self.questionsWithOptions?.count ?? 0
                self.showNextQuestion(sender: 0)
            }, onFailure: { error in
                print(error)
            }).disposed(by: disposeBag)
    }
    
    func showNextQuestion(sender: Int) {
        if sender == 5 {
            skinTypeScore += Double(sender) / 2
        } else {
            skinTypeScore += Double(sender)
        }

        if let questionsWithOptions = questionsWithOptions, currentQuestionIndex < questionsWithOptions.count {
            let nextQuestion = questionsWithOptions[currentQuestionIndex]
            if nextQuestion.2 != currentTestPart {
                showTestResult(for: SkinTestPart(rawValue: currentTestPart) ?? .oily)
                currentTestPart = nextQuestion.2
                skinTypeScore = 0
            }
            progressValue += 1 / Float(questionsWithOptions.count)
            view?.displayQuestion(nextQuestion.0, options: nextQuestion.1)
        } else {
            showTestResult(for: .wrinkled)
            view?.showAlert(message: "Ваш тип записан в личном кабинете в главном меню", {
                self.view?.openSideMenu()
            }, title: "Мы определили ваш тип", okTitle: "Ok")
        }
        currentQuestionIndex += 1
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

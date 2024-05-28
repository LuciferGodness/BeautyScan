//
//  ScanVM.swift
//  BeautyScan
//
//  Created by admin on 03.12.2023.
//

import Foundation
import Vision
import OpenAISwift


protocol PScanVM {
    func scanTextFromImage(cgImage: CGImage)
    func sendOpenAIRequest(_ requestChat: String)
}

final class ScanVM: PScanVM {
    weak var view: PScanVC?
    private var client: OpenAISwift? = {
        let apiKey = ApiKeyManager.getApiKey(forService: "OpenAI")
        
        return OpenAISwift(config: .makeDefaultOpenAI(apiKey: apiKey))
    }()
    
    func scanTextFromImage(cgImage: CGImage) {
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        let request = VNRecognizeTextRequest { request, error in
            guard error == nil else {
                self.handleRecognitionError(error)
                return
            }
            
            if let observations = request.results as? [VNRecognizedTextObservation] {
                let text = observations
                    .compactMap { $0.topCandidates(1).first?.string }
                    .joined(separator: " ")
                
                let requestChat = "\(text); \(AppConfig.openAIText)"
                    self.sendOpenAIRequest(requestChat)
            }
        }
        
        configureTextRecognitionRequest(request)
        
        do {
            try handler.perform([request])
        } catch {
            self.handleRecognitionError(error)
        }
    }
    
    private func configureTextRecognitionRequest(_ request: VNRecognizeTextRequest) {
        request.recognitionLanguages = ["English", "Русский"]
        request.recognitionLevel = .fast
    }
    
   func sendOpenAIRequest(_ requestChat: String) {
        let chatArr = [ChatMessage(role: .user, content: requestChat)]
        self.client?.sendChat(with: chatArr,
                              temperature: 0.1,
                              maxTokens: 3500,
                              completionHandler: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let model):
                    self.view?.setText(text: model.choices?.first?.message.content)
                case .failure(let error):
                    self.handleRecognitionError(error)
                    self.view?.endLoading()
                }
            }
        })
    }
    
    private func handleRecognitionError(_ error: Error?) {
        if let error = error {
            self.view?.showAlert(message: error.localizedDescription, nil,
                                 title: LocalizationKeys.error.localized(),
                                 okTitle: LocalizationKeys.ok.localized())
        }
    }
}

//
//  ScanVC.swift
//  BeautyScan
//
//  Created by admin on 23.11.2023.
//

import UIKit
import PhotosUI
import AVFoundation

protocol PScanVC: PBaseVC {
    func setText(text: String?)
}

final class ScanVC: BaseVC, PScanVC {
    @IBOutlet private weak var productDescription: UITextView!
    @IBOutlet private weak var loadedImage: UIImageView!
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    var vm: PScanVM?
    private let searchField = UITextField(frame: CGRect(x: DesignConstants.zero,
                                                        y: DesignConstants.zero,
                                                        width: DesignConstants.searchFieldWidth,
                                                        height: DesignConstants.searchFieldHeight))
    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private var overlayView: UIView!
    private var generalInfo = ""
    private var ingredients = ""
    private var alternatives = ""
    private var originalText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        setupSegmentControl()
        setupTextField()
        productDescription.delegate = self
    }
    
    private func setupSegmentControl() {
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColors.whiteAsset.color]
        let titleTextAttributesDisabled = [NSAttributedString.Key.foregroundColor: AppColors.grayAsset.color]
        segmentControl.setTitleTextAttributes(titleTextAttributes as [NSAttributedString.Key : Any],
                                              for: .selected)
        segmentControl.setTitleTextAttributes(titleTextAttributesDisabled as [NSAttributedString.Key : Any],
                                              for: .disabled)
        segmentControl.addTarget(self, action: #selector(segmentControlValueChanged(_:)), for: .valueChanged)
    }
    
    private func setupTextField() {
        searchField.delegate = self
        searchField.setLeftPaddingPoints(DesignConstants.scanWidth)
        searchField.backgroundColor = AppColors.whiteAsset.color
        searchField.layer.cornerRadius = DesignConstants.searchFieldCornerRadius
        searchField.leftView = UIView(frame: .init(x: DesignConstants.zero,
                                                   y: DesignConstants.zero,
                                                   width: DesignConstants.scanWidth,
                                                   height: searchField.frame.height))
        searchField.textColor = AppColors.blackAsset.color
        searchField.placeholder = LocalizationKeys.productLink.localized()
        navigationItem.titleView = searchField
    }
    
    @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {
        updateLabelForSelectedSegment()
    }
    
    func updateLabelForSelectedSegment() {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            productDescription.text = generalInfo
        case 1:
            productDescription.text = ingredients
        case 2:
            productDescription.text = alternatives
        default:
            productDescription.text = originalText
        }
    }
    
    func setText(text: String?) {
        endLoading()
        guard let range1 = text?.range(of: LocalizationKeys.general.localized()),
              let range2 = text?.range(of: LocalizationKeys.ingredients.localized()),
              let range3 = text?.range(of: LocalizationKeys.alternatives.localized()) else {
            return
        }
        
        generalInfo = String(text?[range1.upperBound..<range2.lowerBound] ?? "")
        ingredients = String(text?[range2.upperBound..<range3.lowerBound] ?? "")
        alternatives = String(text?[range3.upperBound...] ?? "")
        updateLabelForSelectedSegment()
    }
    
    private func startProcessingImage() {
        productDescription.text = ""
        guard let cgImage = loadedImage.image?.cgImage else { return }
        vm?.scanTextFromImage(cgImage: cgImage)
        startLoading()
    }
    
    @IBAction private func startLoadingImage() {
        startProcessingImage()
    }
    
    @IBAction private func openScan() {
        self.present(ScanerAssembler.assemble(delegate: self), animated: true)
    }
    
    @IBAction private func openGallery() {
        openPhotoLibrary()
    }
    
    // MARK: - Navigation
    
}

extension ScanVC: PHPickerViewControllerDelegate, UINavigationControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        for result in results {
            let itemProvider = result.itemProvider

            guard itemProvider.canLoadObject(ofClass: UIImage.self) else {
                self.showAlert(message: "\(LocalizationKeys.assetType.localized()) \(itemProvider.registeredTypeIdentifiers)", nil,
                               title: LocalizationKeys.error.localized(),
                               okTitle: LocalizationKeys.ok.localized())
                continue
            }

            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                guard let self = self else { return }

                if let error = error {
                    self.showAlert(message: error.localizedDescription, nil,
                                   title: LocalizationKeys.error.localized(),
                                   okTitle: LocalizationKeys.ok.localized())
                    return
                }

                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        self.loadedImage.image = image
                        self.startProcessingImage()
                    }
                }
            }
        }
    }
    
    private func openPhotoLibrary() {
        var config = PHPickerConfiguration()
        config.selectionLimit = DesignConstants.one
        config.filter = PHPickerFilter.images
        
        let pickerViewController = PHPickerViewController(configuration: config)
        pickerViewController.delegate = self
        self.present(pickerViewController, animated: true, completion: nil)
    }
}

extension ScanVC: ScanerVCDelegate {
    func didCapturePhoto(_ image: UIImage) {
        loadedImage.image = image
    }
}

extension ScanVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        startLoading()
        
        let textToSend: String
        if let productName = extractProductName(from: textField.text ?? "") {
            textToSend = "\(productName); \(AppConfig.openAIText)"
        } else {
            textToSend = "\(textField.text ?? ""); \(AppConfig.openAIText)"
        }
        
        vm?.sendOpenAIRequest(textToSend)
        
        return true
    }
    
    func extractProductName(from url: String) -> String? {
        let components = url.components(separatedBy: "/")
        if let index = components.firstIndex(of: "product") {
            let productNameComponents = components[(index + DesignConstants.one)...]
            let productName = productNameComponents.joined(separator: " ")
            return productName
        }
        
        if let lastComponent = components.last {
            let productName = lastComponent.replacingOccurrences(of: "-", with: " ")
            return productName
        }
        
        return nil
    }
}

extension ScanVC: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL,
                  in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        UIApplication.shared.open(URL)
        return false
    }
}


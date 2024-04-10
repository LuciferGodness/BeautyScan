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
    @IBOutlet private weak var productDescription: UILabel!
    @IBOutlet private weak var loadedImage: UIImageView!
    @IBOutlet private weak var segmentControl: UISegmentedControl!
    var vm: PScanVM?
    private var captureSession: AVCaptureSession!
    private var previewLayer: AVCaptureVideoPreviewLayer!
    private var overlayView: UIView!
    private var generalInfo = ""
    private var ingredients = ""
    private var alternatives = ""
    private var originalText = ""
    
    //TODO: addLocalizable
    override var navigationBarTitle: String? {
        "Scan"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: AppColors.whiteAsset.color]
        let titleTextAttributesDisabled = [NSAttributedString.Key.foregroundColor: AppColors.grayAsset.color]
        segmentControl.setTitleTextAttributes(titleTextAttributes as [NSAttributedString.Key : Any],
                                              for: .selected)
        segmentControl.setTitleTextAttributes(titleTextAttributesDisabled as [NSAttributedString.Key : Any],
                                              for: .disabled)
        segmentControl.addTarget(self, action: #selector(segmentControlValueChanged(_:)), for: .valueChanged)
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
        //TODO: addLocalizable
        guard let range1 = text?.range(of: "Общее:"), let range2 = text?.range(of: "Ингредиенты:"), let range3 = text?.range(of: "Альтернативы:") else { return }
        
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
                self.showAlert(message: "Unsupported asset type: \(itemProvider.registeredTypeIdentifiers)", nil, title: "Error", okTitle: "OK")
                continue
            }

            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                guard let self = self else { return }

                if let error = error {
                    self.showAlert(message: error.localizedDescription, nil, title: "Error", okTitle: "OK")
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
        config.selectionLimit = 1
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

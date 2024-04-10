//
//  ScanerVC.swift
//  BeautyScan
//
//  Created by Admin on 3/16/24.
//

import UIKit
import AVFoundation

protocol PScanerVC: AnyObject {
    
}

protocol ScanerVCDelegate: AnyObject {
    func didCapturePhoto(_ image: UIImage)
}

final class ScanerVC: UIViewController, PScanerVC {
    var scannerViewModel: PScanerVM?
    weak var delegate: ScanerVCDelegate?
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer(session: scannerViewModel?.session ?? AVCaptureSession())
        layer.videoGravity = .resizeAspectFill
        return layer
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        previewLayer.frame = view.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layer.addSublayer(previewLayer)
        setupFrontView()
        scannerViewModel?.setupCamera { [weak self] success in
            if success {
                DispatchQueue.main.async {
                    self?.previewLayer.session = self?.scannerViewModel?.session
                }
            } else {
                // Handle setup failure
            }
        }
    }
    
    private func setupFrontView() {
        if let scannerView = loadScannerView() {
            scannerView.setup {
                self.scannerViewModel?.takePhoto(delegate: self)
            }
            view.addSubview(scannerView)
            view.bringSubviewToFront(scannerView)
        }
    }
    
    private func loadScannerView() -> ScannerView? {
        let nib = UINib(nibName: "ScannerView", bundle: nil)
        guard let scannerView = nib.instantiate(withOwner: nil, options: nil).first as? ScannerView else {
            return nil
        }
        scannerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        return scannerView
    }
}

extension ScanerVC: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: (any Error)?) {
        guard let imageData = photo.fileDataRepresentation(), let image = UIImage(data: imageData) else {
            return
        }
        delegate?.didCapturePhoto(image)
        dismiss(animated: true, completion: nil)
    }
}

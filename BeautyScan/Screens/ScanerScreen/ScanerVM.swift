//
//  ScanerVM.swift
//  BeautyScan
//
//  Created by Admin on 3/24/24.
//

import Foundation
import AVFoundation

protocol PScanerVM {
    func setupCamera(completion: @escaping (Bool) -> Void)
    func takePhoto(delegate: AVCapturePhotoCaptureDelegate)
    var session: AVCaptureSession? { get }
}

final class ScanerVM: PScanerVM {
    private let output: AVCapturePhotoOutput = AVCapturePhotoOutput()
    var session: AVCaptureSession?
    weak var vc: PScanerVC?
    
    func setupCamera(completion: @escaping (Bool) -> Void) {
        let session = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                
                if session.canAddOutput(output) {
                    session.addOutput(output)
                }
                
                session.startRunning()
                self.session = session
                completion(true)
                return
            } catch {
                completion(false)
                return
            }
        }
        completion(false)
    }
    
    func takePhoto(delegate: AVCapturePhotoCaptureDelegate) {
        output.capturePhoto(with: AVCapturePhotoSettings(),
                            delegate: delegate)
    }
}

//
//  CameraManager.swift
//  TestTask
//
//  Created by Temur Chitashvili on 14.12.24.
//

import AVFoundation
import UIKit

class CameraManager: ObservableObject {
    @Published var permissionGranted = false
    @Published var permissionDenied = false
    
    func requestPermission() {
        AVCaptureDevice.requestAccess(for: .video) { accessGranted in
            DispatchQueue.main.async {
                if accessGranted {
                    self.permissionGranted = true
                    self.permissionDenied = false
                } else {
                    self.permissionGranted = false
                    self.permissionDenied = true
                }
            }
        }
    }
    
    func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

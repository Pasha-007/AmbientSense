//
//  LightSensor.swift
//  AmbientSense
//
//  Created by Muntahaa Khan on 15/4/25.
//

import AVFoundation
import Combine

class LightSensor: NSObject, ObservableObject {
    private let session = AVCaptureSession()
    private var videoDevice: AVCaptureDevice?
    private var timer: Timer?

    @Published var currentLux: Float = 0.0

    override init() {
        super.init()
        setupCamera()
    }

    private func setupCamera() {
        session.beginConfiguration()

        guard let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .back) else {
            print("No camera available")
            return
        }

        videoDevice = device

        guard let input = try? AVCaptureDeviceInput(device: device) else { return }

        if session.canAddInput(input) {
            session.addInput(input)
        }

        session.commitConfiguration()
    }

    func startMonitoring() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.session.startRunning()
        }

        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
            self.updateLux()
        }
    }

    func stopMonitoring() {
        session.stopRunning()
        timer?.invalidate()
        timer = nil
    }

    private func updateLux() {
        guard let device = videoDevice else { return }

        let iso = device.iso
        let aperture = device.lensAperture
        let exposureDuration = CMTimeGetSeconds(device.exposureDuration)
        let exposure = Float(exposureDuration)

        // Calculate a synthetic light level score: smaller means brighter
        let syntheticValue = (exposure * iso) / (aperture * aperture + 0.0001)

        // Convert to a readable lux-like scale (inverted and scaled)
        let brightnessEstimate = 1 / (syntheticValue + 0.01)
        let scaledLux = Float(brightnessEstimate * 10000)

        DispatchQueue.main.async {
            self.currentLux = Float(Int(scaledLux))
        }
    }
    var cameraSession: AVCaptureSession {
        return session
    }
}

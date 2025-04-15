//
//  AmbientMonitorViewModel.swift
//  AmbientSense
//
//  Created by Muntahaa Khan on 15/4/25.
//

import Foundation
import Combine
import AVFoundation

class AmbientMonitorViewModel: ObservableObject {
    // Published properties for UI
    @Published var noiseDB: Float = 0.0
    @Published var lux: Float = 0.0

    // Sensor objects
    private var audioMonitor = AudioMonitor()
    private var lightSensor = LightSensor()

    // Combine subscriptions
    private var cancellables = Set<AnyCancellable>()

    init() {
        // Subscribe to noise updates
        audioMonitor.$currentDB
            .receive(on: RunLoop.main)
            .assign(to: \.noiseDB, on: self)
            .store(in: &cancellables)

        // Subscribe to light updates
        lightSensor.$currentLux
            .receive(on: RunLoop.main)
            .assign(to: \.lux, on: self)
            .store(in: &cancellables)
        
    }

    func startMonitoring() {
        audioMonitor.startMonitoring()
        lightSensor.startMonitoring()
    }

    func stopMonitoring() {
        audioMonitor.stopMonitoring()
        lightSensor.stopMonitoring()
    }
    var cameraSession: AVCaptureSession {
        return lightSensor.cameraSession
    }
}

//
//  AudioMonitor.swift
//  AmbientSense
//
//  Created by Muntahaa Khan on 15/4/25.
//

import Foundation
import AVFoundation

class AudioMonitor: NSObject, ObservableObject {
    private var audioRecorder: AVAudioRecorder?
    private var timer: Timer?

    @Published var currentDB: Float = 0.0

    func startMonitoring() {
        let audioSession = AVAudioSession.sharedInstance()

        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            try audioSession.setActive(true)

            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatAppleLossless),
                AVSampleRateKey: 44100.0,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
            ]

            let url = URL(fileURLWithPath: "/dev/null") // Don't save anything

            audioRecorder = try AVAudioRecorder(url: url, settings: settings)
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.prepareToRecord()
            audioRecorder?.record()

            timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
                self.audioRecorder?.updateMeters()
                let avgPower = self.audioRecorder?.averagePower(forChannel: 0) ?? -160
                self.currentDB = self.mapPowerToDB(avgPower)
                print("Mic power: \(avgPower) → \(self.currentDB)")
            }
            

        } catch {
            print("Failed to set up audio session: \(error.localizedDescription)")
        }
    }

    func stopMonitoring() {
        timer?.invalidate()
        timer = nil
        audioRecorder?.stop()
        audioRecorder = nil
    }

    private func mapPowerToDB(_ power: Float) -> Float {
        // Approximate mapping from dBFS to SPL (just for visualization)
        let minDb: Float = -80.0
        let maxDb: Float = 0.0
        let normalized = max(0, (power - minDb) / (maxDb - minDb))
        return round(normalized * 100)
    }
}

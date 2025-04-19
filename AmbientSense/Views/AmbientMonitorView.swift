//
//  AmbientMonitorView.swift
//  AmbientSense
//
//  Created by Muntahaa Khan on 15/4/25.
//import SwiftUI

import SwiftUI
import FirebaseAuth

struct AmbientMonitorView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @StateObject private var viewModel = AmbientMonitorViewModel()
    @State private var isMonitoring = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 32) {
                    Text("Ambient Monitor")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 20)

                    // Noise Level Section
                    VStack(spacing: 12) {
                        Text("Noise Level")
                            .font(.title3)
                            .foregroundColor(.gray)

                        Text("\(Int(viewModel.noiseDB)) dB")
                            .font(.system(size: 48, weight: .semibold))
                            .foregroundColor(noiseColor(for: viewModel.noiseDB))

                        Text(noiseStatusText(for: viewModel.noiseDB))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    // Light Level Section
                    VStack(spacing: 12) {
                        Text("Light Level")
                            .font(.title3)
                            .foregroundColor(.gray)

                        CameraPreview(session: viewModel.cameraSession)
                            .frame(height: 200)
                            .cornerRadius(12)
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.gray.opacity(0.3)))

                        Text("\(Int(viewModel.lux)) lux")
                            .font(.system(size: 48, weight: .semibold))
                            .foregroundColor(lightColor(for: viewModel.lux))

                        Text(lightStatusText(for: viewModel.lux))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }

                    Spacer()

                    Button(action: {
                        isMonitoring.toggle()
                        isMonitoring ? viewModel.startMonitoring() : viewModel.stopMonitoring()
                    }) {
                        Text(isMonitoring ? "Stop Monitoring" : "Start Monitoring")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(isMonitoring ? Color.red : Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 40)
                }
                .padding()
            }
//            .navigationTitle("Live Sensor")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Log Out") {
                        authVM.logout()
                    }
                    .foregroundColor(.red)
                }
            }
        }
    }

    // MARK: - Helper Functions

    private func noiseStatusText(for db: Float) -> String {
        switch db {
        case 0..<30: return "Very Quiet"
        case 30..<60: return "Moderate"
        case 60..<80: return "Loud"
        default: return "Very Loud"
        }
    }

    private func noiseColor(for db: Float) -> Color {
        switch db {
        case 0..<30: return .green
        case 30..<60: return .orange
        default: return .red
        }
    }

    private func lightStatusText(for lux: Float) -> String {
        switch lux {
        case 0..<150: return "Dim"
        case 150..<500: return "Ideal"
        case 500..<1000: return "Bright"
        default: return "Extremely Bright"
        }
    }

    private func lightColor(for lux: Float) -> Color {
        switch lux {
        case 0..<150: return .red
        case 150..<500: return .orange
        default: return .green
        }
    }
}

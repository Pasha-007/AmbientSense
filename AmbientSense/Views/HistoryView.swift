//
//  HistoryView.swift
//  AmbientSense
//
//  Created by Muntahaa Khan on 19/4/25.
//

import SwiftUI

struct HistoryView: View {
    @StateObject private var viewModel = MeasurementViewModel()

    var body: some View {
        NavigationView {
            List {
                if viewModel.measurements.isEmpty {
                    Text("No measurements yet.")
                        .foregroundColor(.gray)
                        .padding()
                } else {
                    ForEach(viewModel.measurements) { measurement in
                        VStack(alignment: .leading, spacing: 4) {
                            HStack {
                                Text("Lux:")
                                    .fontWeight(.medium)
                                Text("\(Int(measurement.lux))")
                                    .foregroundColor(.blue)
                            }

                            HStack {
                                Text("dB:")
                                    .fontWeight(.medium)
                                Text("\(Int(measurement.decibel))")
                                    .foregroundColor(.green)
                            }

                            Text(measurement.timestamp.formatted(.dateTime.day().month().year().hour().minute()))
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 6)
                    }
                }
            }
            .navigationTitle("History")
            .onAppear {
                viewModel.fetchMeasurements()
            }
        }
    }
}

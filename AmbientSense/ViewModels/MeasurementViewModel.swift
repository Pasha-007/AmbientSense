//
//  MeasurementViewModel.swift
//  AmbientSense
//
//  Created by Muntahaa Khan on 19/4/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestore

class MeasurementViewModel: ObservableObject {
    @Published var measurements: [Measurement] = []

    private var db = Firestore.firestore()

    private var userId: String? {
        Auth.auth().currentUser?.uid
    }

    // Save measurement to Firestore
    func saveMeasurement(lux: Double, decibel: Double) {
        guard let userId = userId else { return }

        let newMeasurement = Measurement(
            userId: userId,
            lux: lux,
            decibel: decibel,
            timestamp: Date()
        )

        do {
            _ = try db.collection("measurements").addDocument(from: newMeasurement)
        } catch {
            print("Error saving measurement: \(error.localizedDescription)")
        }
    }

    // Fetch all measurements for the current user
    func fetchMeasurements() {
        guard let userId = userId else { return }

        db.collection("measurements")
            .whereField("userId", isEqualTo: userId)
            .order(by: "timestamp", descending: true)
            .addSnapshotListener { snapshot, error in
                if let error = error {
                    print("Error fetching: \(error.localizedDescription)")
                    return
                }

                self.measurements = snapshot?.documents.compactMap { doc in
                    try? doc.data(as: Measurement.self)
                } ?? []
            }
    }
}

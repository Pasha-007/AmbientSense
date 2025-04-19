//
//  Measurement.swift
//  AmbientSense
//
//  Created by Muntahaa Khan on 19/4/25.
//

import Foundation
import FirebaseFirestore

struct Measurement: Identifiable, Codable {
    @DocumentID var id: String? = UUID().uuidString
    var userId: String
    var lux: Double
    var decibel: Double
    var timestamp: Date
}

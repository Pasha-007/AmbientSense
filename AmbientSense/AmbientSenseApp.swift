//
//  AmbientSenseApp.swift
//  AmbientSense
//
//  Created by Muntahaa Khan on 15/4/25.
//

import SwiftUI
import FirebaseCore

@main
struct AmbientSenseApp: App {
    @StateObject private var authVM = AuthViewModel()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(authVM)  // Injected here once globally
        }
    }
}

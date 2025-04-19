//
//  RootView.swift
//  AmbientSense
//
//  Created by Muntahaa Khan on 19/4/25.
//

import SwiftUI

struct RootView: View {
    @StateObject private var authVM = AuthViewModel()

    var body: some View {
        Group {
            if authVM.user != nil {
                AmbientMonitorView()
                    .environmentObject(authVM)
            } else {
                LoginView()
                    .environmentObject(authVM)
            }
        }
    }
}

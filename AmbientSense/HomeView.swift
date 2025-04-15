//
//  ContentView.swift
//  AmbientSense
//
//  Created by Muntahaa Khan on 15/4/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack { // ✅ use NavigationStack for iOS 16+, or NavigationView for older versions
            VStack(spacing: 20) {
                NavigationLink(destination: AmbientMonitorView()) {
                    Text("Open Ambient Monitor")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
            }
            .padding()
            .navigationTitle("AmbientSense")
        }
    }
}

//#Preview {
//    NavigationStack {
//        HomeView()
//    }
//}

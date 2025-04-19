//
//  ContentView.swift
//  AmbientSense
//
//  Created by Muntahaa Khan on 15/4/25.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to AmbientSense!")
                    .font(.title)
                    .padding()

                Button("Log Out") {
                    authVM.logout()
                }
                .foregroundColor(.red)
            }
            .navigationTitle("Home")
        }
    }
}

//#Preview {
//    NavigationStack {
//        HomeView()
//    }
//}

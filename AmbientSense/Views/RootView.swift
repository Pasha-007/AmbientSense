//
//  RootView.swift
//  AmbientSense
//
//  Created by Muntahaa Khan on 19/4/25.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var authVM: AuthViewModel
    

    var body: some View {
        Group {
            if authVM.user != nil {
                MainTabView()
                    .environmentObject(authVM)
            } else {
                LoginView()
                    .environmentObject(authVM)
            }
        }
    }
}

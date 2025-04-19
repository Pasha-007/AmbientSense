//
//  AccountView.swift
//  AmbientSense
//
//  Created by Muntahaa Khan on 19/4/25.
//

import SwiftUI
import FirebaseAuth

struct AccountView: View {
    @EnvironmentObject var authVM: AuthViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if let email = authVM.user?.email {
                    VStack(spacing: 8) {
                        Text("Logged in as:")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        Text(email)
                            .font(.title3)
                            .fontWeight(.medium)
                            .multilineTextAlignment(.center)
                    }
                }

                Button(action: {
                    authVM.logout()
                }) {
                    Text("Log Out")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding()
            .navigationTitle("Account")
        }
    }
}

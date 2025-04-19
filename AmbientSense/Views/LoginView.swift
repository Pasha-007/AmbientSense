//
//  LoginView.swift
//  AmbientSense
//
//  Created by Muntahaa Khan on 19/4/25.
//

import SwiftUI
enum AuthScreenState {
    case login, register
}

struct LoginView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    @State private var screenState: AuthScreenState = .register

    var body: some View {
        VStack(spacing: 16) {
            Text(screenState == .login ? "Log In" : "Register")
                .font(.title)

            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
            }

            Button(screenState == .login ? "Log In" : "Register") {
                if screenState == .login {
                    authVM.login(email: email, password: password) { error in
                        errorMessage = error?.localizedDescription ?? ""
                    }
                } else {
                    authVM.register(email: email, password: password) { error in
                        errorMessage = error?.localizedDescription ?? ""
                    }
                }
            }

            Button(screenState == .login ? "Don't have an account? Register" : "Already have an account? Log In") {
                screenState = screenState == .login ? .register : .login
            }
            .foregroundColor(.blue)
        }
        .padding()
    }
}

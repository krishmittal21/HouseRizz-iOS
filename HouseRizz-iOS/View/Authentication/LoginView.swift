//
//  LoginView.swift
//  HouseRizz-iOS
//
//  Created by Krish Mittal on 04/04/24.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var viewModel = Authentication()
    @State var isSignupView = false
    
    private func signInWithEmailPassword() {
        Task {
            await viewModel.signInWithEmailPassword()
        }
    }
    private func signInWithGoogle() {
        Task {
            await viewModel.signInWithGoogle()
        }
    }
    
    var body: some View {
        VStack {
            VStack{
                Text("HouseRizz")
                    .bold()
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom,20)
                
                HStack {
                    Image(systemName: "at")
                    TextField("Email", text: $viewModel.email)
                        .textInputAutocapitalization(.never)
                        .disableAutocorrection(true)
                        .submitLabel(.next)
                    
                }
                .padding(.vertical, 6)
                .background(Divider(), alignment: .bottom)
                .padding(.bottom, 4)
                
                HStack {
                    Image(systemName: "lock")
                    SecureField("Password", text: $viewModel.password)
                        .submitLabel(.go)
                }
                .padding(.vertical, 6)
                .background(Divider(), alignment: .bottom)
                .padding(.bottom, 8)
                
                if viewModel.authenticationState != .authenticating {
                    HRAuthenticationButton(label: "Login") {
                        signInWithEmailPassword()
                    }
                } else {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .black))
                        .padding(.vertical, 8)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
            
            HStack {
                VStack { Divider() }
                Text("or")
                VStack { Divider() }
            }
            
            VStack(spacing: 10){
                HRAuthenticationButton(label: "Sign in with Google", iconImage: Image("google")) {
                    signInWithGoogle()
                }
                SignInWithAppleButton(.signIn) { request in
                    viewModel.handleSignInWithAppleRequest(request)
                } onCompletion: { result in
                    viewModel.handleSignInWithAppleCompletion(result)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .padding(.vertical, 15)
                .cornerRadius(8)
                .signInWithAppleButtonStyle(.white)
                .shadow(color: colorScheme == .dark ? Color.white.opacity(0.2) : Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                HRAuthenticationButton(label: "Sign up with Email", iconName: "envelope.fill") {
                    isSignupView.toggle()
                }
            }
            .padding()
        }
        .listStyle(.plain)
        .padding()
        .padding(.top,200)
        .sheet(isPresented: $isSignupView) {
            SignupView()
        }
    }
}

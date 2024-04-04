//
//  SettingsView.swift
//  HouseRizz-iOS
//
//  Created by Krish Mittal on 04/04/24.
//

import SwiftUI

struct SettingsView: View {
    @StateObject var auth = Authentication()
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    HStack {
                        Image(systemName: "envelope")
                        Text("Email")
                        Spacer()
                        if let user = auth.user {
                            Text(user.email)
                                .foregroundStyle(.gray)
                        } else {
                            Text("Loading Profile ..")
                                .foregroundStyle(.gray)
                        }
                    }
                } header: {
                    Text("Account")
                }
                Section {
                    HStack {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                        Text("Sign out")
                    }
                    .foregroundStyle(.red)
                    .onTapGesture {
                        auth.signOut()
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.red)
                    }
                    
                }
            }
            .onAppear {
                auth.fetchUser()
            }
        }
    }
}

#Preview {
    SettingsView()
}

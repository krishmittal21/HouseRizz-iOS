//
//  CartView.swift
//  HouseRizz-iOS
//
//  Created by Krish Mittal on 12/04/24.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    @StateObject private var authViewModel = Authentication()
    @State private var showAlert: Bool = false
    @State private var navigateToUPIView: Bool = false
    @State private var navigateToSetting: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if !cartViewModel.products.isEmpty {
                    ScrollView {
                        ForEach(cartViewModel.products, id: \.product.id) { cartItem in
                            CartProductView(cartItem: cartItem)
                                .environmentObject(cartViewModel)
                        }
                    }
                    
                    Divider()
                    
                    HStack {
                        Text("Your Total is ")
                        Spacer()
                        Text((cartViewModel.total).formattedCurrency())
                            .bold()
                    }
                    .padding()
                    
                    Button(action: {
                        if authViewModel.user?.address != "Not Provided" && authViewModel.user?.phoneNumber != "Not Provided" {
                            navigateToUPIView = true
                        } else if authViewModel.user?.name != "Anonymous User" {
                            navigateToUPIView = true
                        } else {
                            showAlert = true
                        }
                    }) {
                        Text("Proceed to Checkout")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.primaryColor)
                            .cornerRadius(10)
                            .padding()
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Cannot Proceed Further. Complete Profile"),
                            message: Text("Make Sure to sign In and provide your address and phone number to proceed."),
                            primaryButton: .default(Text("Go to Settings"), action: {
                                navigateToSetting.toggle()
                            }),
                            secondaryButton: .cancel()
                        )
                    }
                    .sheet(isPresented: $navigateToUPIView) {
                        UPIView()
                    }
                    .sheet(isPresented: $navigateToSetting) {
                        SettingsView()
                    }
                } else {
                    Text("Your Cart is Empty")
                }
            }
            .padding(.vertical)
            .onAppear {
                authViewModel.fetchUser()
            }
        }
        .navigationTitle("My Cart")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    CartView()
        .environmentObject(CartViewModel())
}

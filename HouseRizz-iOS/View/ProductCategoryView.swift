//
//  ProductCategoryView.swift
//  HouseRizz-iOS
//
//  Created by Krish Mittal on 16/04/24.
//

import SwiftUI

struct ProductCategoryView: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    @State private var selectedProduct: HRProduct?

    var column = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    var productCategory: Category

    var body: some View {
        NavigationView {
            VStack {
                SearchView()
                    .padding(.top, 10)

                ScrollView {
                    LazyVGrid(columns: column) {
                        ForEach(productList.filter { $0.category == productCategory }, id: \.id) { product in
                            ProductCardView(product: product)
                                .environmentObject(cartViewModel)
                                .onTapGesture {
                                    selectedProduct = product
                                }
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle(productCategory.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                NavigationLink(destination: CartView().environmentObject(cartViewModel)) {
                    CartButton(numberOfProducts: cartViewModel.products.count)
                }
            }
        }
        .sheet(item: $selectedProduct) { product in
            ProductDetailsView(product: product)
                .environmentObject(cartViewModel)
        }
    }
}

#Preview {
    ProductCategoryView(productCategory: Category.sofa)
        .environmentObject(CartViewModel())
}

//
//  ProductView.swift
//  HouseRizz-iOS
//
//  Created by Krish Mittal on 11/04/24.
//

import SwiftUI

struct ProductView: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .top) {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    AppBar
                    
                    SearchView()
                    
                    ImageSliderView()
                    
                    HStack {
                        Text("New Arrivals")
                            .font(.title2)
                            .fontWeight(.medium)
                        
                        Spacer()
                        
                        Image(systemName: "circle.grid.2x2.fill")
                            .foregroundStyle(.purple.opacity(0.2))
                    }
                    .padding()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(productList, id: \.id) {product in
                                NavigationLink{
                                    Text(product.name)
                                } label: {
                                    ProductCardView(product: product)
                                        .environmentObject(cartViewModel)
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .environmentObject(cartViewModel)
        }
    }
    
    @ViewBuilder
    var AppBar: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "location.north.fill")
                    .resizable()
                    .frame(width: 20,height: 20)
                    .padding(.trailing)
                
                Text("Delhi, India")
                    .font(.title2)
                    .foregroundStyle(.gray)
                
                Spacer()
                
                NavigationLink(destination: Text("")) {
                    CartButton(numberOfProducts: cartViewModel.products.count)
                }
            }
            
            Text("Get The Most Realistic")
                .font(.largeTitle .bold())
            
            + Text(" Furniture Experience")
                .font(.largeTitle .bold())
                .foregroundStyle(.purple.opacity(0.4))
        }
        .padding()
    }
}

struct ProductView_Preview: PreviewProvider {
    static var previews: some View {
        ProductView()
            .environmentObject(CartViewModel())
    }
}

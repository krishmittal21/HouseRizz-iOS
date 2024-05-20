//
//  CKProductCardView.swift
//  HouseRizz-iOS
//
//  Created by Krish Mittal on 20/05/24.
//

import SwiftUI

struct VendorProductCardView: View {
    var product: HRCKProduct
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading) {
                if let url = product.imageURL1, let data = try? Data(contentsOf: url), let image = UIImage(data: data){
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 175,height: 160)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(.gray, lineWidth: 0.5)
                            )
                }
                
                Text(product.name)
                    .font(.subheadline)
                    .padding(.vertical, 1)
                    .foregroundStyle(.black)
                
                Text("₹ \(product.price ?? 0)")
                    .font(.caption2)
                    .foregroundStyle(.black)
            }
        }
        .frame(width: 185, height: 260)
        .cornerRadius(15)
    }
}
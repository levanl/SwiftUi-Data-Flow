//
//  StoreView.swift
//  SwiftUi DataFlow
//
//  Created by Levan Loladze on 09.12.23.
//

import SwiftUI

struct StoreView: View {
    @ObservedObject var viewModel: StoreViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.products) { product in
                    StoreProductView(product: product, viewModel: viewModel)
                }
                .listStyle(PlainListStyle())
                .cornerRadius(10)
                
                Button(action: {
                    viewModel.discountProducts(precentage: 20)
                }) {
                    Text("Discount 20%")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .foregroundColor(.white)
                        .font(.headline)
                }
                .disabled(viewModel.hasDiscounted)
                .background(viewModel.hasDiscounted ? .gray : .orange)
                .cornerRadius(10)
                
                HStack {
                    Text("Total: ₾\(String(format: "%.2f", viewModel.total))")
                        .font(.headline)
                        .padding()
                }
            }
            .padding()
            .navigationTitle("Store")
        }
    }
}



struct StoreProductView: View {
    var product: Product
    @ObservedObject var viewModel: StoreViewModel
    
    var selectedQuantity: Int {
        viewModel.selectedQuantities[product.id] ?? 0
    }
    
    var body: some View {
        HStack(spacing: 0) {
            Image(product.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: .infinity)
                .clipped()
            VStack {
                Text(product.name)
                
                Text("Price: ₾\(product.price, specifier: "%.2f")")
                    .foregroundColor(.gray)
                Text("Quantity: \(product.quantity)")
                    .foregroundColor(product.isOutOfStock ? .red : .green)
            }
            .padding()
            
            Spacer()
            
            VStack {
                HStack{
                    Text("\(selectedQuantity)")
                }
                .padding(5)
                
                HStack {
                    Button(action: {
                        viewModel.addSelectedQuantity(productID: product.id)
                    }) {
                        Image(systemName: "plus.circle")
                            .foregroundColor(.green)
                    }
                    .disabled(product.quantity == 0)
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: {
                        viewModel.deductSelectedQuantity(productID: product.id)
                    }) {
                        Image(systemName: "minus.circle")
                            .foregroundColor(.red)
                    }
                    .disabled(selectedQuantity == 0)
                    .buttonStyle(PlainButtonStyle())
                }
            }
            
            Spacer()
            
            Button(action: {
                viewModel.deleteProduct(productID: product.id)
            }) {
                HStack {
                    Image(systemName: "trash")
                        .foregroundColor(.white)
                }
                .padding(8)
                .background(Color.red)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

#Preview {
    StoreView(viewModel: StoreViewModel())
}

//
//  StoreViewModel.swift
//  SwiftUi DataFlow
//
//  Created by Levan Loladze on 09.12.23.
//

import Foundation
import SwiftUI



class StoreViewModel: ObservableObject {
    
    @Published var products: [Product] = [
        Product(name: "ხინკალი", quantity: 99, price: 1.0, isOutOfStock: false, imageName: "ხინკალი"),
        Product(name: "Banana", quantity: 15, price: 1.20, isOutOfStock: false, imageName: "banana"),
        Product(name: "Orange", quantity: 20, price: 1.50, isOutOfStock: false, imageName: "orange"),
    ]
    
    @Published var cart: [Product] = []
    
    @Published var selectedQuantities: [UUID: Int] = [:]
    
    @Published var hasDiscounted = false
    
    var total: Double {
        var sum = 0.0
        for product in products {
            if let quantity = selectedQuantities[product.id] {
                sum += Double(quantity) * product.price
            }
        }
        return sum
    }
    
    // MARK: Adding SelectedQuantity
    func addSelectedQuantity(productID: UUID) {
        guard let productIndex = products.firstIndex(where: { $0.id == productID }) else {
            return
        }
        
        guard let currentQuantity = selectedQuantities[productID] else {
            selectedQuantities[productID] = 1
            products[productIndex].quantity -= 1
            return
        }
        
        if products[productIndex].quantity > 0 {
            selectedQuantities[productID] = currentQuantity + 1
            products[productIndex].quantity -= 1
            print(products[productIndex].quantity)
        }
    }
    
    // MARK: Deducting SelectedQuantity
    func deductSelectedQuantity(productID: UUID) {
        guard let productIndex = products.firstIndex(where: { $0.id == productID }) else {
            return
        }
        
        guard let currentQuantity = selectedQuantities[productID] else {
            selectedQuantities[productID] = 1
            return
        }
        
        if currentQuantity > 0 {
            selectedQuantities[productID] = currentQuantity - 1
            products[productIndex].quantity += 1
        } else {
            return
        }
        
    }
    
    func deleteProduct(productID: UUID) {
        if let productIndex = products.firstIndex(where: { $0.id == productID }) {
            products.remove(at: productIndex)
        }
    }
    
    func discountProducts(precentage: Double) {
        
        products = products.map { product in
            hasDiscounted = true
            var updatedProduct = product
            
            updatedProduct.price = (updatedProduct.price * (100 - precentage)) / 100
            print(updatedProduct.price)
            return updatedProduct
        }
    }
    
}

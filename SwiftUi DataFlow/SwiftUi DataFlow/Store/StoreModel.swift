//
//  StoreModel.swift
//  SwiftUi DataFlow
//
//  Created by Levan Loladze on 09.12.23.
//

import Foundation

struct Product: Identifiable {
    let id = UUID()
    let name: String
    var quantity: Int
    var price: Double
    var isOutOfStock: Bool
    var imageName: String
}

//
//  PantryProduct.swift
//  purrchase
//
//  Created by Diogo Camargo on 19/05/25.
//

import UIKit
import Foundation

final class PantryProduct: Codable {
    var id = UUID()
    var name: String
    var category: Category
    var image: UIImage?
    var expirationDate: Date?
    var price: Double?

    init(name: String,
         category: Category,
         image: UIImage? = nil,
         expirationDate: Date? = nil,
         price: Double? = nil) {
        self.name = name
        self.category = category
        self.image = image
        self.expirationDate = expirationDate
        self.price = price
    }
}
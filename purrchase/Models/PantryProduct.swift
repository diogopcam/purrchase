//
//  PantryProduct.swift
//  purrchase
//
//  Created by Diogo Camargo on 19/05/25.
//


//
//  PantryProduct.swift
//  purrchase
//
//  Created by Diogo Camargo on 19/05/25.
//

import UIKit
import Foundation

class PantryProduct: Codable {
    var id = UUID()
    var name: String
    var category: Category
    var image: String
    var expirationDate: Date?
    var price: Double?

    init(name: String,
         category: Category,
         image: String,
         expirationDate: Date? = nil,
         price: Double? = nil) {
        self.name = name
        self.category = category
        self.image = image
        self.expirationDate = expirationDate
        self.price = price
    }
}

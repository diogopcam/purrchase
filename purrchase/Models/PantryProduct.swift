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
    var expirationDate: Date?
    var price: Double?
    var imageName: String?
    
    var image: UIImage? {
        guard let imageName = imageName else { return nil }
        return ProductStorageService.shared.loadImage(named: imageName)
    }

    init(
        id: UUID = UUID(),
        name: String,
        category: Category,
        imageName: String? = nil,
        expirationDate: Date? = nil,
        price: Double? = nil) {
        self.name = name
        self.category = category
        self.imageName = imageName
        self.expirationDate = expirationDate
        self.price = price
    }
}

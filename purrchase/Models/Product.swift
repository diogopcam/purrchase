//
//  Product.swift
//  purrchase
//
//  Created by Diogo Camargo on 14/05/25.
//
import UIKit
import Foundation

class Product: Codable {
    let id: UUID
    var name: String
    var category: Category
    var amount: Int
    var observation: String?
    var imageName: String?

    var image: UIImage? {
        guard let imageName = imageName else { return nil }
        return ProductStorageService.shared.loadImage(named: imageName)
    }

    init(
        id: UUID = UUID(),
        name: String,
        category: Category,
        amount: Int,
        observation: String? = nil,
        imageName: String? = nil
    ) {
        self.id = id
        self.name = name
        self.category = category
        self.amount = amount
        self.observation = observation
        self.imageName = imageName
    }

    convenience init(
        name: String,
        category: Category,
        amount: Int,
        observation: String? = nil,
        image: UIImage?
    ) {
        let imageName = image != nil ? "product_\(UUID().uuidString).jpg" : nil
        
        self.init(
            name: name,
            category: category,
            amount: amount,
            observation: observation,
            imageName: imageName
        )
//
//        if let image = image, let imageName = imageName {
//            ProductStorageService.shared.saveImage(image, named: imageName)
//        }
    }
}

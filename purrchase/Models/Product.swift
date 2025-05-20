//
//  Product.swift
//  purrchase
//
//  Created by Diogo Camargo on 14/05/25.
//
import UIKit
import Foundation

final class Product: Codable {
    var id = UUID()
    var name: String
    var category: Category
    var amount: Int
    var observation: String?
    var image: String?

    init(name: String, category: Category, amount: Int, observation: String? = nil, image: String? = nil) {
        self.name = name
        self.category = category
        self.amount = amount
        self.observation = observation
        self.image = image
    }
}

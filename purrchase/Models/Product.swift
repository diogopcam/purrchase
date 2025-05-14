//
//  Product.swift
//  purrchase
//
//  Created by Diogo Camargo on 14/05/25.
//
import UIKit
import Foundation

final class Product: Codable {
    var name: String
    var category: Category
    var amount: Int
    var observation: String?

    init(name: String, category: Category, amount: Int, observation: String? = nil) {
        self.name = name
        self.category = category
        self.amount = amount
        self.observation = observation
    }
}

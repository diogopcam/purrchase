//
//  Category.swift
//  purrchase
//
//  Created by Diogo Camargo on 14/05/25.
//

enum Category: String, Codable, CaseIterable {
    case vegetables = "Vegetables"
    case fruits = "Fruits"
    case meats = "Meats"
    case bread = "Bread"
    case sweets = "Sweets"
    case drinks = "Drinks"
    case hygiene = "Hygiene"
    case petSupplies = "Pet Supplies"
    case medicine = "Medicine"
    case dairy = "Dairy"
    case others = "Others"
}

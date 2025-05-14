//
//  Recipe.swift
//  purrchase
//
//  Created by Diogo Camargo on 14/05/25.
//
import UIKit
import Foundation

final class Recipe: Codable {
    var id: UUID = UUID()
    var name: String
    var image: String
    var ingredients: [Product]
    var steps: [String]
    
    init(name: String, image: String, ingredients: [Product], steps: [String]) {
        self.name = name
        self.image = image
        self.ingredients = ingredients
        self.steps = steps
    }
}

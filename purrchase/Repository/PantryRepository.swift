//
//  LocalPantryRepository.swift
//  purrchase
//
//  Created by Diogo Camargo on 19/05/25.
//

import Foundation

class PantryRepository {
    private var pantry: [Product] = []

    func getAllProducts() -> [Product] {
        return pantry
    }

    func addProduct(_ product: Product) {
        pantry.append(product)
    }

    func removeProduct(_ product: Product) {
        pantry.removeAll { $0.id == product.id }
    }

    func updateProduct(_ product: Product) {
        if let index = pantry.firstIndex(where: { $0.id == product.id }) {
            pantry[index] = product
        }
    }
}

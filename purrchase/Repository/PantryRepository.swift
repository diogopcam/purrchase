//
//  LocalPantryRepository.swift
//  purrchase
//
//  Created by Diogo Camargo on 19/05/25.
//

import Foundation

class PantryRepository {
    private var pantry: [PantryProduct] = []

    func getAllProducts() -> [PantryProduct] {
        return pantry
    }

    func addProduct(_ product: PantryProduct) {
        pantry.append(product)
    }

    func removeProduct(_ product: PantryProduct) {
        pantry.removeAll { $0.id == product.id }
    }

    func updateProduct(_ product: PantryProduct) {
        if let index = pantry.firstIndex(where: { $0.id == product.id }) {
            pantry[index] = product
        }
    }
}

//
//  PantryController.swift
//  purrchase
//
//  Created by Diogo Camargo on 19/05/25.
//

import Foundation

class PantryController {
    let repository = PantryRepository()
    
    init(repository: PantryRepository) {
        self.repository = repository
    }
    
    func getPantryItems() -> [PantryProduct] {
        return repository.getAllProducts()
    }
    
    func addToPantry(_ product: PantryProduct) {
        repository.addProduct(product)
    }
    
    func removeFromPantry(_ product: PantryProduct) {
        repository.removeProduct(product)
    }
}

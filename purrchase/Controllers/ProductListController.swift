//
//  ProductListController.swift
//  purrchase
//
//  Created by Diogo Camargo on 19/05/25.
//


import Foundation

class ProductListController {
    let repository = ProductListRepository()
    private(set) var lists: [ProductList] = []
    
    init() {
        lists = repository.load()
    }
    
    func addList(_ list: ProductList) {
        lists.append(list)
        repository.save(lists)
    }
    
    func removeList(at index: Int) {
        guard index < lists.count else { return }
        lists.remove(at: index)
        repository.save(lists)
    }

    func updateList(at index: Int, with updatedList: ProductList) {
        guard index < lists.count else { return }
        lists[index] = updatedList
        repository.save(lists)
    }
}

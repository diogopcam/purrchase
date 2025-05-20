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
        if lists.isEmpty {
            let defaultList = ProductList(list: [], colorName: "Circle-1", name: "Rancho1")
            addList(defaultList)
        }
    }

    func loadLists() {
        lists = repository.load()
    }

    func addList(_ list: ProductList) {
        lists.append(list)
        repository.save(lists)
        loadLists()
    }

    func removeList(at index: Int) {
        guard index < lists.count else { return }
        lists.remove(at: index)
        repository.save(lists)
        loadLists()
    }

    func updateList(at index: Int, with updatedList: ProductList) {
        guard index < lists.count else { return }
        lists[index] = updatedList
        repository.save(lists)
        loadLists()
    }

    func updateList(_ updatedList: ProductList) {
        guard let index = lists.firstIndex(where: { $0.id == updatedList.id }) else { return }
        lists[index] = updatedList
        repository.save(lists)
        loadLists()
    }

    func addProduct(_ product: Product, toListWithId listId: UUID) {
        guard let index = lists.firstIndex(where: { $0.id == listId }) else {
            print("❌ Lista com ID \(listId) não encontrada.")
            return
        }

        lists[index].list.append(product)
        repository.save(lists)
        loadLists()
        print("✅ Produto '\(product.name)' adicionado à lista '\(lists[index].name)'.")
    }
    
//    func getListProducts()
}


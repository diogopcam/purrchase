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
    
    // ✅ Novo método para adicionar um produto a uma lista pelo ID
    func addProduct(_ product: Product, toListWithId listId: UUID) {
        guard let index = lists.firstIndex(where: { $0.id == listId }) else {
            print("❌ Lista com ID \(listId) não encontrada.")
            return
        }

        lists[index].list.append(product)
        repository.save(lists)
        print("✅ Produto '\(product.name)' adicionado à lista '\(lists[index].name)'.")
    }
}

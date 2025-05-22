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
    
    func removeListByID(_ listID: UUID) {
        guard let index = lists.firstIndex(where: { $0.id == listID }) else { return }
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
    
    func updateProduct(_ updated: Product, inListWithId listId: UUID) {
        guard let li = lists.firstIndex(where: { $0.id == listId }),
              let pi = lists[li].list.firstIndex(where: { $0.id == updated.id })
        else { return }

        lists[li].list[pi] = updated
        repository.save(lists)
        loadLists()
    }
    
    func removeProduct(_ productId: UUID, fromListWithId listId: UUID) {
        guard let listIndex = lists.firstIndex(where: { $0.id == listId }) else {
            print("❌ Lista com ID \(listId) não encontrada.")
            return
        }

        guard let productIndex = lists[listIndex].list.firstIndex(where: { $0.id == productId }) else {
            print("❌ Produto com ID \(productId) não encontrado na lista.")
            return
        }

        let removedProduct = lists[listIndex].list.remove(at: productIndex)
        repository.save(lists)
        loadLists()
        print("🗑️ Produto '\(removedProduct.name)' removido da lista '\(lists[listIndex].name)'.")
    }
}

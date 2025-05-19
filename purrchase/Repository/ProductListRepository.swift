//
//  ProductListRepository.swift
//  purrchase
//
//  Created by Diogo Camargo on 19/05/25.
//

import Foundation

final class ProductListRepository {
    let key = "productLists"

    func save(_ productLists: [ProductList]) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(productLists)
            UserDefaults.standard.set(data, forKey: key)
        } catch {
            print("Erro ao salvar listas de produtos no UserDefaults: \(error)")
        }
    }

    func load() -> [ProductList] {
        guard let data = UserDefaults.standard.data(forKey: key) else { return [] }

        do {
            let decoder = JSONDecoder()
            return try decoder.decode([ProductList].self, from: data)
        } catch {
            print("Erro ao carregar listas de produtos do UserDefaults: \(error)")
            return []
        }
    }
    
    func printAllProducts() {
        let productLists = load()
        
        print("🔍 Listando todos os produtos de todas as listas:")
        
        for (index, list) in productLists.enumerated() {
            print("📦 Lista \(index + 1): \(list.name)")
            for product in list.list {
                print("  - 🛒 Produto: \(product.name), Categoria: \(product.category), Quantidade: \(product.amount), Observação: \(product.observation ?? "nenhuma")")
            }
        }
    }
}

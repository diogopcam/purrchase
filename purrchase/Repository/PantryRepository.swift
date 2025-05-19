import Foundation

class PantryRepository {
    private var pantry: [PantryProduct] = []
    
    // Carrega os produtos armazenados
    func load() -> [PantryProduct] {
        return pantry
    }
    
    // Salva o array completo de produtos
    func save(_ products: [PantryProduct]) {
        pantry = products
    }
    
    // Adiciona um produto à lista local
    func addProduct(_ product: PantryProduct) {
        pantry.append(product)
    }
    
    // Remove um produto por ID
    func removeProduct(_ product: PantryProduct) {
        pantry.removeAll { $0.id == product.id }
    }
    
    // Atualiza um produto na lista local
    func updateProduct(_ product: PantryProduct) {
        if let index = pantry.firstIndex(where: { $0.id == product.id }) {
            pantry[index] = product
        }
    }
}

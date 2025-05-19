import Foundation

class PantryController {
    let repository = PantryRepository()
    private(set) var pantryItems: [PantryProduct] = []
    
    init() {
        pantryItems = repository.load()
    }
    
    func addToPantry(_ product: PantryProduct) {
        pantryItems.append(product)
        repository.save(pantryItems)
    }
    
    func removeFromPantry(at index: Int) {
        guard index < pantryItems.count else { return }
        pantryItems.remove(at: index)
        repository.save(pantryItems)
    }
    
    func updatePantryItem(at index: Int, with updatedProduct: PantryProduct) {
        guard index < pantryItems.count else { return }
        pantryItems[index] = updatedProduct
        repository.save(pantryItems)
    }
    
    func printAllPantryProducts() {
        guard !pantryItems.isEmpty else {
            print("Não há produtos na despensa.")
            return
        }
        
        for (index, product) in pantryItems.enumerated() {
            print("Produto \(index + 1):")
            print("  Nome: \(product.name)")
            print("  Categoria: \(product.category)")
            print("  Imagem: \(product.image)")
            if let expirationDate = product.expirationDate {
                let formatter = DateFormatter()
                formatter.dateStyle = .short
                print("  Validade: \(formatter.string(from: expirationDate))")
            } else {
                print("  Validade: Não informada")
            }
            if let price = product.price {
                print("  Preço: R$\(price)")
            } else {
                print("  Preço: Não informado")
            }
            print("--------------------")
        }
    }
}

import Foundation

class PantryController {
    let repository = PantryRepository()
    private(set) var pantry: [PantryProduct] = []

    init() {
        pantry = repository.load()
    }

    func getPantryItems() -> [PantryProduct] {
        return pantry
    }

    func addToPantry(_ product: PantryProduct) {
        pantry.append(product)
        repository.save(pantry)
    }

    func removeFromPantry(_ product: PantryProduct) {
        pantry.removeAll { $0.id == product.id }
        repository.save(pantry)
    }

    func updateProduct(_ product: PantryProduct) {
        if let index = pantry.firstIndex(where: { $0.id == product.id }) {
            pantry[index] = product
            repository.save(pantry)
        }
    }

    func printAllPantryProducts() {
        guard !pantry.isEmpty else {
            print("Não há produtos na despensa.")
            return
        }

        for (index, product) in pantry.enumerated() {
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

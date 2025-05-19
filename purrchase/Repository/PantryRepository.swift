import Foundation

class PantryRepository {
    private let storageKey = "pantry_products"

    func load() -> [PantryProduct] {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let products = try? JSONDecoder().decode([PantryProduct].self, from: data) {
            return products
        }
        return []
    }

    func save(_ products: [PantryProduct]) {
        if let data = try? JSONEncoder().encode(products) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }
}

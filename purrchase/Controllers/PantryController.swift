class PantryController {
    private let repository: PantryRepository
    
    init(repository: PantryRepository) {
        self.repository = repository
    }
    
    func getPantryItems() -> [Product] {
        return repository.getAllProducts()
    }
    
    func addToPantry(_ product: Product) {
        repository.addProduct(product)
    }
    
    func removeFromPantry(_ product: Product) {
        repository.removeProduct(product)
    }
}
protocol Validatable {
    func validate() -> Bool
    var errorMessage: String? { get }
}
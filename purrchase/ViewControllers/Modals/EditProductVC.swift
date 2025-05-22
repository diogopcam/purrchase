////
////  EditProduct.swift
////  purrchase
////
////  Created by Richard Fagundes Rodrigues on 16/05/25.
////
//
//import UIKit
//
//protocol EditProductDelegate: AnyObject {
//    func didUpdateProduct(_ updatedProduct: Product)
//    func didDeleteProduct(_ deletedProduct: Product)
//}
//
//class EditProductVC: UIViewController {
//    
//    private var dropdownView: ImagePickerOptionsView?
//    private var dropdownIsVisible = false
//    private var outsideTapGesture: UITapGestureRecognizer?
//    
//    var controller: ProductListController
//    var productList: ProductList
//    var product: Product
//    weak var delegate: EditProductDelegate?
//    
//    init(controller: ProductListController, productList: ProductList, product: Product) {
//        self.controller = controller
//        self.productList = productList
//        self.product = product
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    lazy var header: NavBarComponent = {
//        let nav = NavBarComponent()
//        nav.translatesAutoresizingMaskIntoConstraints = false
//        nav.firstButtonTitle = "Cancel"
//        nav.title = "Edit Product"
//        nav.secondButtonTitle = "Done"
//        nav.cancelButtonAction = { [weak self] in self?.dismiss(animated: true) }
//        nav.doneButtonAction = { [weak self] in self?.doneButtonTapped() }
//        return nav
//    }()
//    
//    lazy var imagePickerButton: ImagePickerButton = {
//        let button = ImagePickerButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
//    
//    lazy var productComponent: ProductImageComponent = {
//        var productImage = ProductImageComponent()
//        productImage.translatesAutoresizingMaskIntoConstraints = false
//        productImage.image = .banana
//        productImage.name = "Banana"
//        return productImage
//    }()
//    
//    lazy var categoryComponent: CategorySelectorComponent = {
//        var categorySelector = CategorySelectorComponent()
//        categorySelector.translatesAutoresizingMaskIntoConstraints = false
//        categorySelector.labelTitle = "Category"
//        return categorySelector
//    }()
//    
//    lazy var amount: AmountComponent = {
//        var amountComponent = AmountComponent()
//        amountComponent.translatesAutoresizingMaskIntoConstraints = false
//        return amountComponent
//    }()
//    
//    lazy var stack: UIStackView = {
//        let stack = UIStackView(arrangedSubviews: [categoryComponent, amount])
//        stack.axis = .vertical
//        stack.spacing = 24
//        stack.distribution = .fill
//        stack.translatesAutoresizingMaskIntoConstraints = false
//        return stack
//        }()
//    
//    lazy var deleteButton: DeleteButtonComponent = {
//        let btn = DeleteButtonComponent()
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.deleteButton.addTarget(self, action: #selector(deleteProduct), for: .touchUpInside)
//        return btn
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        setupDropdownToggle()
//        setupDismissKeyboardGesture()
//        setup()
//        populateFields()
//    }
//    
//    private func setupDismissKeyboardGesture() {
//            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//            tap.cancelsTouchesInView = false
//            view.addGestureRecognizer(tap)
//        }
//    
//    @objc private func dismissKeyboard() {
//            view.endEditing(true)
//        }
//
//    private func setupDropdownToggle() {
//        imagePickerButton.addTarget(self, action: #selector(toggleDropdown), for: .touchUpInside)
//    }
//
//    @objc private func toggleDropdown() {
//        dropdownIsVisible ? hideDropdown() : showDropdown()
//    }
//
//    private func showDropdown() {
//        guard let superview = imagePickerButton.superview else { return }
//        let dropdown = ImagePickerOptionsView()
//        dropdown.translatesAutoresizingMaskIntoConstraints = false
//        dropdown.onSelect = { [weak self] index in
//            self?.handleDropdownSelection(index: index)
//            self?.hideDropdown()
//        }
//        view.addSubview(dropdown)
//        let frame = imagePickerButton.convert(imagePickerButton.bounds, to: view)
//        NSLayoutConstraint.activate([
//            dropdown.topAnchor.constraint(equalTo: view.topAnchor, constant: frame.maxY + 4),
//            dropdown.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: frame.minX),
//            dropdown.widthAnchor.constraint(equalToConstant: frame.width),
//            dropdown.heightAnchor.constraint(equalToConstant: CGFloat(dropdown.options.count) * 44)
//        ])
//        dropdown.alpha = 0
//        UIView.animate(withDuration: 0.25) { dropdown.alpha = 1 }
//        dropdownView = dropdown; dropdownIsVisible = true
//    }
//
//    @objc private func handleOutsideTap(_ sender: UITapGestureRecognizer) {
//        guard let dropdown = dropdownView else { return }
//        let loc = sender.location(in: view)
//        if !dropdown.frame.contains(loc) && !imagePickerButton.frame.contains(loc) {
//            hideDropdown()
//        }
//    }
//
//    private func hideDropdown() {
//        guard let dropdown = dropdownView else { return }
//        UIView.animate(withDuration: 0.25, animations: { dropdown.alpha = 0 }) { _ in
//            dropdown.removeFromSuperview()
//        }
//        dropdownIsVisible = false
//    }
//
//    private func handleDropdownSelection(index: Int) {
//        // configurar imagem selecionada
//    }
//
//    // MARK: - Actions
//    private func doneButtonTapped() {
//        // TODO: Adicionar aqui o ajuste da foto
//        guard let name = productComponent.name, !name.isEmpty else { return }
//        guard let selectedCategory = categoryComponent.selectedCategory else { return }
//        let amount = amount.value
//
//        // Atualiza modelo
//        // TODO: Adicionar aqui o ajuste da foto
//        product.name = name
//        product.category = selectedCategory
//        product.amount = amount
//
//        // Persiste alteração usando método específico
//        controller.updateProduct(product, inListWithId: productList.id)
//        delegate?.didUpdateProduct(product)
//        dismiss(animated: true)
//    }
//
//    @objc private func deleteProduct() {
//        controller.removeProduct(product.id, fromListWithId: productList.id)
//        delegate?.didDeleteProduct(product)
//        dismiss(animated: true)
//    }
//
//    // MARK: - Helpers
//    private func populateFields() {
//        // TODO: Adicionar aqui o ajuste da foto
//        productComponent.name = product.name
//        categoryComponent.selectedCategory = product.category
//        amount.value = product.amount
//    }
//}
//
//extension EditProductVC: ViewCodeProtocol {
//    func addSubViews() {
//        view.addSubview(header)
//        view.addSubview(productComponent)
//        view.addSubview(categoryComponent)
//        view.addSubview(amount)
//        view.addSubview(deleteButton)
//    }
//    
//    func setupConstraints() {
//        NSLayoutConstraint.activate([
//            header.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            header.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
//            
//            productComponent.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 41),
//            productComponent.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            
//            categoryComponent.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            categoryComponent.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            categoryComponent.topAnchor.constraint(equalTo: productComponent.bottomAnchor, constant: 40),
//            categoryComponent.heightAnchor.constraint(equalToConstant: 60),
//            
//            amount.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            amount.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            amount.topAnchor.constraint(equalTo: categoryComponent.bottomAnchor, constant: 24),
//            amount.heightAnchor.constraint(equalToConstant: 50),
//            
//            deleteButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            deleteButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48),
//        ])
//    }
//}

//
//  EditProduct.swift
//  purrchase
//
//  Created by Richard Fagundes Rodrigues on 16/05/25.
//

import UIKit

protocol EditPantryProductDelegate: AnyObject {
    func didUpdatePantryProduct(_ product: PantryProduct)
    func didDeletePantryProduct(_ product: PantryProduct)
}

class EditPantryProductVC: UIViewController {
    let controller: PantryController
    var product: PantryProduct
    weak var delegate: EditPantryProductDelegate?
    
    private var dropdownView: ImagePickerOptionsView?
    private var dropdownIsVisible = false
    
    // MARK: - Init
    init(controller: PantryController, product: PantryProduct) {
        self.controller = controller
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private let contentView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    // MARK: - UI Components
    lazy var header: NavBarComponent = {
        let nav = NavBarComponent()
        nav.translatesAutoresizingMaskIntoConstraints = false
        nav.firstButtonTitle = "Cancel"
        nav.title = "Edit Product"
        nav.secondButtonTitle = "Done"
        nav.cancelButtonAction = { [weak self] in self?.dismiss(animated: true) }
        nav.doneButtonAction = { [weak self] in self?.doneButtonTapped() }
        return nav
    }()
    
    lazy var imagePickerButton: ImagePickerButton = {
        let btn = ImagePickerButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    lazy var productComponent: ProductImageComponent = {
        let comp = ProductImageComponent()
        comp.translatesAutoresizingMaskIntoConstraints = false
        return comp
    }()
    
    lazy var categoryComponent: CategorySelectorComponent = {
        let comp = CategorySelectorComponent()
        comp.translatesAutoresizingMaskIntoConstraints = false
        comp.labelTitle = "Category"
        return comp
    }()
    
    lazy var expirationDatePicker: NamedDatePicker = {
        let comp = NamedDatePicker()
        comp.translatesAutoresizingMaskIntoConstraints = false
        comp.name = "Expiration Date"
        return comp
    }()
    
    lazy var priceField: NamedTextField = {
        let tf = NamedTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.name = "Last Purchase Value"
        tf.placeholder = "R$xx,xx"
        tf.nameFont = UIFont(name: "Poppins-Medium", size: 17)
        tf.placeholderFont = UIFont(name: "Poppins-Medium", size: 17)!
        tf.placeholderColor = .textAndIcons
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return tf
    }()
    
    lazy var infoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            categoryComponent,
            expirationDatePicker,
            priceField
        ])
        stack.axis = .vertical
        stack.spacing = 24
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var deleteButton: DeleteButtonComponent = {
        let btn = DeleteButtonComponent()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupDismissKeyboardGesture()
        setupDropdownToggle()
        setup()
        populateFields()
    }
    
    private func setupDismissKeyboardGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc private func dismissKeyboard() { view.endEditing(true) }

    private func setupDropdownToggle() {
        imagePickerButton.addTarget(self, action: #selector(toggleDropdown), for: .touchUpInside)
    }
    @objc private func toggleDropdown() {
        dropdownIsVisible ? hideDropdown() : showDropdown()
    }
    private func showDropdown() {
        let dropdown = ImagePickerOptionsView()
        dropdown.translatesAutoresizingMaskIntoConstraints = false
        dropdown.onSelect = { [weak self] idx in
            self?.handleDropdownSelection(index: idx); self?.hideDropdown()
        }
        view.addSubview(dropdown)
        let frame = imagePickerButton.convert(imagePickerButton.bounds, to: view)
        NSLayoutConstraint.activate([
            dropdown.topAnchor.constraint(equalTo: view.topAnchor, constant: frame.maxY + 4),
            dropdown.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: frame.minX),
            dropdown.widthAnchor.constraint(equalToConstant: frame.width),
            dropdown.heightAnchor.constraint(equalToConstant: CGFloat(dropdown.options.count) * 44)
        ])
        dropdown.alpha = 0; UIView.animate(withDuration: 0.25) { dropdown.alpha = 1 }
        dropdownView = dropdown; dropdownIsVisible = true
    }
    private func hideDropdown() {
        guard let dd = dropdownView else { return }
        UIView.animate(withDuration: 0.25, animations: { dd.alpha = 0 }) { _ in dd.removeFromSuperview() }
        dropdownIsVisible = false
    }
    private func handleDropdownSelection(index: Int) {
        // TODO: set productComponent.image/name
    }
    
    // MARK: - Actions
    @objc private func doneButtonTapped() {
        guard let name = productComponent.name, !name.isEmpty else { return }
        guard let category = categoryComponent.selectedCategory else { return }

        let expDate = expirationDatePicker.date
        product.expirationDate = expDate

        if let text = priceField.text?
            .replacingOccurrences(of: "R$", with: "")
            .replacingOccurrences(of: ",", with: "."),
           let priceValue = Double(text) {
            product.price = priceValue
        }

        product.name = name
        product.category = category

        controller.updateProduct(product)
        delegate?.didUpdatePantryProduct(product)
        dismiss(animated: true)
    }
    
    @objc private func deleteButtonTapped() {
        controller.removeFromPantry(product)
        delegate?.didDeletePantryProduct(product)
        dismiss(animated: true)
    }
    
    // MARK: - Helpers
    private func populateFields() {
        productComponent.name = product.name
        categoryComponent.selectedCategory = product.category
        if let img = product.image {
            productComponent.image = img
        } else {
            productComponent.image = .apple
        }
        if let date = product.expirationDate { expirationDatePicker.date = date }
        if let price = product.price {
            priceField.text = String(format: "R$%.2f", price)
        }
    }
}

extension EditPantryProductVC: ViewCodeProtocol {
    func addSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(header)
        contentView.addSubview(productComponent)
        contentView.addSubview(infoStackView)
        
        view.addSubview(deleteButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            // ScrollView ocupa a tela, exceto espaço do botão de deletar
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: deleteButton.topAnchor),

            // contentView com largura igual à da view (importante para scroll vertical)
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            // Header
            header.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            header.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),

            // Product
            productComponent.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 16),
            productComponent.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            productComponent.textLabel.widthAnchor.constraint(equalToConstant: 1000),

            // InfoStack
            infoStackView.topAnchor.constraint(equalTo: productComponent.bottomAnchor, constant: 16),
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20), // necessário p/ rolar tudo
            

            // Delete button fixo
            deleteButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            deleteButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            deleteButton.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
}

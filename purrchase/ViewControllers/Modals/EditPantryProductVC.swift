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
    private var selectedImage: UIImage?
    
    private var dropdownView: ImagePickerOptionsView?
    private var dropdownIsVisible = false
    private var outsideTapGesture: UITapGestureRecognizer?
    
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
        tf.textField.addTarget(self, action: #selector(clearPriceFieldIfNeeded), for: .editingDidBegin)
        return tf
    }()
    
    @objc private func clearPriceFieldIfNeeded() {
        guard let text = priceField.textField.text, !text.isEmpty else { return }
        priceField.textField.text = ""
    }
    
    lazy var infoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [categoryComponent, expirationDatePicker, priceField])
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
        
        let tapDismissKeyboard = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapDismissKeyboard)
        view.backgroundColor = .white
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(toggleDropdown))
        productComponent.imageView.isUserInteractionEnabled = true
        productComponent.imageView.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setup()
        populateFields()
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let bottomInset = keyboardFrame.height - view.safeAreaInsets.bottom
        scrollView.contentInset.bottom = bottomInset
        scrollView.verticalScrollIndicatorInsets.bottom = bottomInset
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset.bottom = 0
        scrollView.verticalScrollIndicatorInsets.bottom = 0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc private func toggleDropdown() {
        dropdownIsVisible ? hideDropdown() : showDropdown()
    }
    private func showDropdown() {
        let dropdown = ImagePickerOptionsView()
        dropdown.translatesAutoresizingMaskIntoConstraints = false
        dropdown.onSelect = { [weak self] idx in
            self?.handleDropdownSelection(index: idx)
            self?.hideDropdown()
        }
        
        view.addSubview(dropdown)
        
        let frame = productComponent.imageView.convert(productComponent.imageView.bounds, to: view)
        
        NSLayoutConstraint.activate([
            dropdown.topAnchor.constraint(equalTo: view.topAnchor, constant: frame.maxY + 4),
            dropdown.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: frame.minX),
            dropdown.widthAnchor.constraint(equalToConstant: frame.width),
            dropdown.heightAnchor.constraint(equalToConstant: CGFloat(dropdown.options.count) * 44)
        ])
        
        dropdown.alpha = 0
        UIView.animate(withDuration: 0.25) {
            dropdown.alpha = 1
        }
        
        dropdownView = dropdown
        dropdownIsVisible = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleOutsideTap(_:)))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        outsideTapGesture = tapGesture
    }
    
    @objc private func handleOutsideTap(_ sender: UITapGestureRecognizer) {
        guard let dropdown = dropdownView else { return }
        let location = sender.location(in: view)
        if !dropdown.frame.contains(location) && !productComponent.imageView.frame.contains(location) {
            hideDropdown()
        }
    }
    
    private func hideDropdown() {
        guard let dropdown = dropdownView else { return }
        UIView.animate(withDuration: 0.25, animations: {
            dropdown.alpha = 0
        }, completion: { _ in
            dropdown.removeFromSuperview()
        })
        dropdownIsVisible = false
        
        if let tap = outsideTapGesture {
            view.removeGestureRecognizer(tap)
            outsideTapGesture = nil
        }
    }
    
    private func handleDropdownSelection(index: Int) {
        switch index {
        case 0: // Take photo
            openCamera()
        case 1: // Choose from gallery
            openPhotoLibrary()
        case 2: // Our library
            openAppLibrary()
        default:
            break
        }
    }
    
    private func openCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            showAlert(title: "Error", message: "Camera not available")
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    private func openPhotoLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    private func openAppLibrary() {
        let libraryVC = SymbolLibraryVC()
        libraryVC.delegate = self
        let nav = UINavigationController(rootViewController: libraryVC)
        present(nav, animated: true)
        print("Our library selected")
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    // MARK: - Actions
    @objc private func doneButtonTapped() {
        
        guard let name = productComponent.name, !name.isEmpty else {
            showAlert(title: "Name Required", message: "Please enter a product name")
            return
        }
        
        guard let selectedCategory = categoryComponent.selectedCategory else {
            showAlert(title: "Category Required", message: "Please select a category")
            return
        }
        
        if let text = priceField.text?
                .replacingOccurrences(of: "R$", with: "")
                .replacingOccurrences(of: ",", with: "."),
           let priceValue = Double(text) {
            product.price = priceValue
        } else {
            showAlert(title: "Product Value Required", message: "Please select a valid value")
            return
        }

        let expDate = expirationDatePicker.date
        
        var imageName: String? = product.imageName
        
        if let image = selectedImage {
            imageName = ProductStorageService.shared.saveImage(image)
            ProductStorageService.shared.listStoredImages()
        }

        product.name = name
        product.category = selectedCategory
        product.expirationDate = expDate
        product.imageName = imageName

        controller.updateProduct(product)
        delegate?.didUpdatePantryProduct(product)
        self.dismiss(animated: true)
    }
    
    @objc private func deleteButtonTapped() {
        controller.removeFromPantry(product)
        delegate?.didDeletePantryProduct(product)
        dismiss(animated: true)
    }
    
    // MARK: - Helpers
    private func populateFields() {
        productComponent.name = product.name
        //productComponent.textLabel.text = product.name
        categoryComponent.selectedCategory = product.category
        productComponent.image = product.image ?? .nonPhotoProduct

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
            productComponent.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 32),
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

// MARK: - Image Picker Delegate
extension EditPantryProductVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                selectedImage = image
                productComponent.image = image

            }
            picker.dismiss(animated: true)
        }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

extension EditPantryProductVC: SymbolLibraryDelegate {
    func didSelectSymbol(image: UIImage) {
        selectedImage = image
        productComponent.image = image
    }
}

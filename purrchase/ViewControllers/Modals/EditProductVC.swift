import UIKit

protocol EditProductDelegate: AnyObject {
    func didUpdateProduct(_ updatedProduct: Product)
    func didDeleteProduct(_ deletedProduct: Product)
}

class EditProductVC: UIViewController {
    let controller: ProductListController
    let productList: ProductList
    var product: Product
    weak var delegate: EditProductDelegate?
    
    private var dropdownView: ImagePickerOptionsView?
    private var dropdownIsVisible = false
    private var selectedImage: UIImage?
    
    // MARK: - Init
    init(controller: ProductListController, productList: ProductList, product: Product) {
        self.controller = controller
        self.productList = productList
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
//        comp..addTarget(self, action: #selector(toggleDropdown), for: .touchUpInside)
        return comp
    }()
    
    lazy var categoryComponent: CategorySelectorComponent = {
        let comp = CategorySelectorComponent()
        comp.translatesAutoresizingMaskIntoConstraints = false
        comp.labelTitle = "Category"
        return comp
    }()
    
    lazy var amountComponent: AmountComponent = {
        let comp = AmountComponent()
        comp.translatesAutoresizingMaskIntoConstraints = false
        return comp
    }()
    
    lazy var observationsField: NamedTextField = {
        let tf = NamedTextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.name = "Observations"
        tf.placeholder = "Additional information"
        tf.nameFont = UIFont(name: "Poppins-Medium", size: 17)
        tf.placeholderFont = UIFont(name: "Poppins-Medium", size: 17)!
        tf.placeholderColor = .textAndIcons
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return tf
    }()
    
    lazy var infoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            categoryComponent,
            amountComponent,
            observationsField
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
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

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
            self?.handleDropdownSelection(index: idx)
            self?.hideDropdown()
        }
        view.addSubview(dropdown)
        
        let frame = imagePickerButton.convert(imagePickerButton.bounds, to: view)
        
        NSLayoutConstraint.activate([
            dropdown.topAnchor.constraint(equalTo: view.topAnchor, constant: frame.maxY + 4),
            dropdown.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: frame.minX),
            dropdown.widthAnchor.constraint(equalToConstant: frame.width),
            dropdown.heightAnchor.constraint(equalToConstant: CGFloat(dropdown.options.count) * 44)
        ])
        
        dropdown.alpha = 0
        UIView.animate(withDuration: 0.25) { dropdown.alpha = 1 }
        
        dropdownView = dropdown
        dropdownIsVisible = true
    }
    
    private func hideDropdown() {
        guard let dropdown = dropdownView else { return }
        UIView.animate(withDuration: 0.25, animations: {
            dropdown.alpha = 0
        }) { _ in
            dropdown.removeFromSuperview()
        }
        dropdownIsVisible = false
    }
    
    private func handleDropdownSelection(index: Int) {
        switch index {
        case 0: // Take photo
            openCamera()
        case 1: // Choose from gallery
            openPhotoLibrary()
        case 2: // Our library
            // Implement your custom image library here
            print("Our library selected")
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
        
        guard let category = categoryComponent.selectedCategory else {
            showAlert(title: "Category Required", message: "Please select a category")
            return
        }
        
        let amount = amountComponent.value
        let observation = observationsField.text
        
        // Handle image update
        var newImageName: String? = product.imageName
        if let selectedImage = selectedImage {
            // Delete old image if exists
            if let oldImageName = product.imageName {
                ProductStorageService.shared.deleteImage(named: oldImageName)
            }
            // Save new image
            newImageName = ProductStorageService.shared.saveImage(selectedImage)
        }
        
        // Update product
        product.name = name
        product.category = category
        product.amount = amount
        product.observation = observation
        product.imageName = newImageName
        
        // Update in controller
        controller.updateProduct(product, inListWithId: productList.id)
        delegate?.didUpdateProduct(product)
        dismiss(animated: true)
    }
    
    @objc private func deleteButtonTapped() {
        // Delete image if exists
        
        if let imageName = product.imageName {
            ProductStorageService.shared.deleteImage(named: imageName)
        }
        
        controller.removeProduct(product.id, fromListWithId: productList.id)
        delegate?.didDeleteProduct(product)
        dismiss(animated: true)
    }
    
    // MARK: - Helpers
    private func populateFields() {
        productComponent.name = product.name
        productComponent.image = product.image ?? UIImage(systemName: "photo")
        categoryComponent.selectedCategory = product.category
        amountComponent.value = product.amount
        observationsField.text = product.observation
    }
}

// MARK: - Image Picker Delegate
extension EditProductVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

// MARK: - View Code Protocol
extension EditProductVC: ViewCodeProtocol {
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

            // contentView com largura igual à da view
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            // Header
            header.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            header.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),

            // Product Component
            productComponent.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 32),
            productComponent.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            productComponent.textLabel.widthAnchor.constraint(equalToConstant: 1000),

            // InfoStack
            infoStackView.topAnchor.constraint(equalTo: productComponent.bottomAnchor, constant: 16),
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            infoStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            // Delete button fixo
            deleteButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            deleteButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            deleteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            deleteButton.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
}

//
//  AddProductVC.swift
//  purrchase
//
//  Created by Bernardo Garcia Fensterseifer on 15/05/25.
//

import UIKit

class AddProductVC: UIViewController {
    private var dropdownView: ImagePickerOptionsView?
    private var dropdownIsVisible = false
    var controller: ProductListController
    private let productList: ProductList
    weak var delegate: AddProductDelegate?
    private var selectedImage: UIImage?
    private var outsideTapGesture: UITapGestureRecognizer?
    
    init(controller: ProductListController, productList: ProductList) {
        self.controller = controller
        self.productList = productList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    lazy var header: NavBarComponent = {
        var header = NavBarComponent()
        header.translatesAutoresizingMaskIntoConstraints = false
        header.firstButtonTitle = "Cancel"
        header.title = "Products"
        header.secondButtonTitle = "Done"
        
        header.cancelButtonAction = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        header.doneButtonAction = { [weak self] in
            self?.doneButtonTapped()
        }
        
        return header
    }()
    
    lazy var imagePickerButton: ImagePickerButton = {
        let button = ImagePickerButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(toggleDropdown), for: .touchUpInside)
        return button
    }()
    
    lazy var nameTextField: NamedTextField = {
        let textField = NamedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.name = "Name"
        textField.placeholder = "Name of the Product"
        textField.nameFont = UIFont(name: "Poppins-Medium", size: 17)
        textField.placeholderFont = UIFont(name: "Poppins-Medium", size: 17)!
        textField.placeholderColor = .textAndIcons
        return textField
    }()
    
    lazy var photoAndNameStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [imagePickerButton, nameTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 19
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.isUserInteractionEnabled = true
        return stackView
    }()
    
    lazy var category: CategorySelectorComponent = {
        var categorySelectorComponent = CategorySelectorComponent()
        categorySelectorComponent.translatesAutoresizingMaskIntoConstraints = false
        categorySelectorComponent.labelTitle = "Category"
        return categorySelectorComponent
    }()
    
    lazy var amount: AmountComponent = {
        var amountComponent = AmountComponent()
        amountComponent.translatesAutoresizingMaskIntoConstraints = false
        return amountComponent
    }()
    
    lazy var observations: NamedTextField = {
        var observationsTextField = NamedTextField()
        observationsTextField.translatesAutoresizingMaskIntoConstraints = false
        observationsTextField.name = "Observations"
        observationsTextField.placeholder = ""
        observationsTextField.nameFont = UIFont(name: "Poppins-Medium", size: 17)
        observationsTextField.heightAnchor.constraint(equalToConstant: 147).isActive = true
        return observationsTextField
    }()
    
    lazy var stack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [photoAndNameStack, category, amount, observations])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.distribution = .fill
        stackView.isUserInteractionEnabled = true
        return stackView
    }()
    
    private func setupDropdownToggle() {
          imagePickerButton.addTarget(self, action: #selector(toggleDropdown), for: .touchUpInside)
      }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDropdownToggle()
        
        let tapDismissKeyboard = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapDismissKeyboard)
        view.backgroundColor = .white
        
        setup()
    }
    
    // MARK: - Actions
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func toggleDropdown() {
        if dropdownIsVisible {
            hideDropdown()
        } else {
            showDropdown()
        }
    }
    
    private func showDropdown() {
        let dropdown = ImagePickerOptionsView()
        dropdown.translatesAutoresizingMaskIntoConstraints = false
        dropdown.isUserInteractionEnabled = true
        dropdown.onSelect = { [weak self] index in
            self?.handleDropdownSelection(index: index)
            self?.hideDropdown()
        }
        
        view.addSubview(dropdown)
        
        let buttonFrame = imagePickerButton.convert(imagePickerButton.bounds, to: view)
        
        NSLayoutConstraint.activate([
            dropdown.topAnchor.constraint(equalTo: view.topAnchor, constant: buttonFrame.maxY + 4),
            dropdown.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: buttonFrame.minX),
            dropdown.widthAnchor.constraint(equalToConstant: dropdown.dropdownWidth),
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
        if !dropdown.frame.contains(location) && !imagePickerButton.frame.contains(location) {
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
    
    func doneButtonTapped() {
        guard let name = nameTextField.text, !name.isEmpty else {
            showAlert(title: "Name Required", message: "Please enter a product name")
            return
        }

        guard let selectedCategory = category.selectedCategory else {
            showAlert(title: "Category Required", message: "Please select a category")
            return
        }
        
        let amountNum = amount.value
        let observationInfo = observations.text ?? ""
        
        var imageName: String? = nil
        
        if let image = selectedImage {
            // Salva a imagem no storage e pega o nome do arquivo
            imageName = ProductStorageService.shared.saveImage(image)
            ProductStorageService.shared.listStoredImages() // log da
        }
            
        let product = Product(name: name, category: selectedCategory, amount: amountNum, observation: observationInfo, imageName: imageName)
        controller.addProduct(product, toListWithId: productList.id)
        delegate?.didAddProduct(product)
        dismiss(animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - Image Picker Delegate
extension AddProductVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                selectedImage = image
                imagePickerButton.setImage(image, for: .normal)
                imagePickerButton.imageView?.contentMode = .scaleAspectFill
            }
            picker.dismiss(animated: true)
        }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

// MARK: - View Code Protocol
extension AddProductVC: ViewCodeProtocol {
    func addSubViews() {
        view.addSubview(header)
        view.addSubview(stack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            header.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stack.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 15),
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    func setupViews() {
        addSubViews()
        setupConstraints()
    }
}

protocol AddProductDelegate: AnyObject {
    func didAddProduct(_ product: Product)
}


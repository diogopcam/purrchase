//
//  AddProductPantryVC.swift
//  purrchase
//
//  Created by Bernardo Garcia Fensterseifer on 16/05/25.
//

import UIKit
import Foundation

class AddProductPantryVC: UIViewController {
    private var dropdownView: ImagePickerOptionsView?
    private var dropdownIsVisible = false
    private var outsideTapGesture: UITapGestureRecognizer?
    var controller: PantryController
    private var selectedImage: UIImage?
    weak var delegate: AddPantryProductDelegate?
    
    init(controller: PantryController) {
        self.controller = controller
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Header
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
   
    lazy var expirationDate: NamedDatePicker = {
        var expirationDateComponent = NamedDatePicker()
        expirationDateComponent.translatesAutoresizingMaskIntoConstraints = false
        expirationDateComponent.name = "Expiration Date"
        return expirationDateComponent
    }()
    
    lazy var price: NamedTextField = {
        let textField = NamedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.name = "Price"
        textField.placeholder = "R$xx,xx"
        textField.nameFont = UIFont(name: "Poppins-Medium", size: 17)
        textField.placeholderColor = .textAndIcons
        return textField
    }()
    
    lazy var stack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [photoAndNameStack, category, expirationDate, price])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 24
        //stackView.alignment = .center
        stackView.distribution = .fill
        stackView.isUserInteractionEnabled = true
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDropdownToggle()
        
        let tapDismissKeyboard = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapDismissKeyboard)
        view.backgroundColor = .white
        
        setup()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func setupDropdownToggle() {
        imagePickerButton.addTarget(self, action: #selector(toggleDropdown), for: .touchUpInside)
    }
    
    @objc private func toggleDropdown() {
        if dropdownIsVisible {
            hideDropdown()
        } else {
            showDropdown()
        }
    }
    
    private func showDropdown() {
        guard let button = imagePickerButton.superview else { return }
        
        let dropdown = ImagePickerOptionsView()
        dropdown.translatesAutoresizingMaskIntoConstraints = false
        dropdown.onSelect = { [weak self] index in
            self?.handleDropdownSelection(index: index)
            self?.hideDropdown()
        }
        
        view.addSubview(dropdown)
        
        let buttonFrame = imagePickerButton.convert(imagePickerButton.bounds, to: view)
        
        NSLayoutConstraint.activate([
            dropdown.topAnchor.constraint(equalTo: view.topAnchor, constant: buttonFrame.maxY + 4),
            dropdown.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: buttonFrame.minX),
            dropdown.widthAnchor.constraint(equalToConstant: buttonFrame.width),
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
        print("Botão done pressionado!")

        guard let name = nameTextField.text, !name.isEmpty else {
            print("O nome do produto é obrigatório.")
            return
        }

        guard let selectedCategory = category.selectedCategory else {
            print("Selecione uma categoria.")
            return
        }

        guard let priceText = price.text?.replacingOccurrences(of: ",", with: "."),
            let priceValue = Double(priceText) else {
            print("Digite um valor numérico válido para o preço.")
            return
        }
        
        let expirationDate = expirationDate.date
        
        var imageName: String? = nil
        
        if let image = selectedImage {
            // Salva a imagem no storage e pega o nome do arquivo
            imageName = ProductStorageService.shared.saveImage(image)
            ProductStorageService.shared.listStoredImages() // log da
        }
        
        let pantryProduct = PantryProduct(name: name, category: selectedCategory, imageName: imageName, expirationDate: expirationDate, price: priceValue)
        controller.addToPantry(pantryProduct)
        controller.printAllPantryProducts()
        delegate?.didAddProduct()
        self.dismiss(animated: true)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension AddProductPantryVC: ViewCodeProtocol {
    func addSubViews() {
        view.addSubview(header)
        //view.addSubview(photoAndNameStack)
        view.addSubview(stack)
        //view.addSubview(imagePickerButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            header.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
//            imagePickerButton.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 15),
//            imagePickerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            nameTextField.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 33),
//            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
//            nameTextField.leadingAnchor.constraint(equalTo: imagePickerButton.trailingAnchor, constant: 19)
            stack.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 15),
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
}

// MARK: - Image Picker Delegate
extension AddProductPantryVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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


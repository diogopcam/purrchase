//
//  AddProductPantryVC.swift
//  purrchase
//
//  Created by Bernardo Garcia Fensterseifer on 16/05/25.
//

import UIKit
import Foundation

class AddProductPantryVC: UIViewController {
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
        
    //let imagePickerButton = ImagePickerButton()
    
    lazy var imagePickerButton: ImagePickerButton = {
        let button = ImagePickerButton()
        button.translatesAutoresizingMaskIntoConstraints = false
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
    
    private weak var presentingController: UIViewController?

       func configure(presentingController: UIViewController) {
           self.presentingController = presentingController
           imagePickerButton.addTarget(self, action: #selector(showOptions), for: .touchUpInside)
       }

       @objc private func showOptions() {
           let alert = UIAlertController(title: "Escolha uma opção", message: nil, preferredStyle: .actionSheet)

           alert.addAction(UIAlertAction(title: "Galeria", style: .default, handler: { _ in
               print("Selecionou Galeria")
           }))

           alert.addAction(UIAlertAction(title: "Câmera", style: .default, handler: { _ in
               print("Selecionou Câmera")
           }))

           alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))

           presentingController?.present(alert, animated: true, completion: nil)
       }
    
    override func viewDidLoad() {
        imagePickerButton.configure(presentingController: self)
        super.viewDidLoad()
    
//        imagePickerButton.configure(presentingController: self)
        
        let tapDismissKeyboard = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapDismissKeyboard)
        view.backgroundColor = .white
        
        setup()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func doneButtonTapped() {
        print("Botão done pressionado!")

        let requiredFields: [Validatable] = [nameTextField, price]

        for field in requiredFields {
            if !field.validate() {
                showAlert(message: field.errorMessage ?? "Preencha todos os campos corretamente.")
                return
            }
        }

        guard let name = nameTextField.text, !name.isEmpty else {
            showAlert(message: "O nome do produto é obrigatório.")
            return
        }

        guard let selectedCategory = category.selectedCategory else {
            showAlert(message: "Selecione uma categoria.")
            return
        }

        guard let priceText = price.text?.replacingOccurrences(of: ",", with: "."), // trata vírgula
              let priceValue = Double(priceText) else {
            showAlert(message: "Digite um valor numérico válido para o preço.")
            return
        }

        let expiration = expirationDate.date

        let newProduct = PantryProduct(
            name: name,
            category: selectedCategory,
            image: "IMAGEM", // aqui você pode trocar pela imagem real depois
            expirationDate: expiration,
            price: String(format: "%.2f", priceValue)
        )

        controller.addList(newProduct)
        print("Produto adicionado!")
        controller.repository.printAllProducts()
        dismiss(animated: true)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Atenção", message: message, preferredStyle: .alert)
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

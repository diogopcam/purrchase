//
//  AddProductVC.swift
//  purrchase
//
//  Created by Bernardo Garcia Fensterseifer on 15/05/25.
//

import UIKit

class AddProductVC: UIViewController {
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
        
//        header.doneButtonAction = { [weak self] in
//            self?.doneButtonTapped()
//        }
        
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
        //observationsTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 11).isActive = true
        return observationsTextField
    }()
    
    lazy var stack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [photoAndNameStack, category, amount, observations])
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
    
    // FAZER A FUNCAO DO DoneButtonTapped
//    func doneButtonTapped() {
        // falta coisa aq dentro
//        dismiss(animated: true)
//    }
}

extension AddProductVC: ViewCodeProtocol {
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

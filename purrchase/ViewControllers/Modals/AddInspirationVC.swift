//
//  InspirationModalVC.swift
//  purrchase
//
//  Created by Bernardo Garcia Fensterseifer on 21/05/25.
//

import UIKit
import Foundation

class AddInspirationVC: UIViewController {
    private var dropdownView: ImagePickerOptionsView?
    private var dropdownIsVisible = false
    private var outsideTapGesture: UITapGestureRecognizer?
    //var controller: PantryController
    
    init() {
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
        header.title = "New Recipe"
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
    
    lazy var contactComponentLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Contact"
        label.font = UIFont(name: "Poppins-Medium", size: 14)
        label.textColor = .grayText
        return label
    }()
    
    lazy var contactImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Message-Icon")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.widthAnchor.constraint(equalToConstant: 26).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 26).isActive = true
        return imageView
    }()
    
    lazy var contactLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Contact Us"
        label.font = UIFont(name: "Poppins-SemiBold", size: 17)
        return label
    }()
    
    lazy var contactGreaterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Greater-Icon")
        imageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    lazy var contactHorizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [contactImage, contactLabel, UIView(), contactGreaterImage])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        return stack
    }()
    
    lazy var contactComponentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [contactHorizontalStack])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .backgroundPrimaria
        stackView.layer.cornerRadius = 17
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
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
        
        // Adicionar tap gesture para fechar dropdown ao clicar fora
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
        print("Selecionou opção: \(dropdownView?.options[index].title ?? "")")
        // Aqui você pode fazer a ação que quiser
    }
    
    func doneButtonTapped() {
        print("Botão done pressionado!")

        guard let name = nameTextField.text, !name.isEmpty else {
            print("O nome do produto é obrigatório.")
            return
        }

        
//        let expirationDate = expirationDate.date
//        
//        let pantryProduct = PantryProduct(name: name, category: selectedCategory, image: "IMAGEM", expirationDate: expirationDate, price: priceValue)
//        
//        controller.addToPantry(pantryProduct)
//        controller.printAllPantryProducts()
        self.dismiss(animated: true)
    }
}

extension AddInspirationVC: ViewCodeProtocol {
    func addSubViews() {
        view.addSubview(header)
        //view.addSubview(photoAndNameStack)
        //view.addSubview(stack)
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
//            stack.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 15),
//            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
//            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
}

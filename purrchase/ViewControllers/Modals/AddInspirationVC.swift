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
    
    lazy var nameTextField: NamedTextField = {
        let textField = NamedTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.name = "Name"
        textField.placeholder = "Name of the Recipe"
        textField.nameFont = UIFont(name: "Poppins-Medium", size: 17)
        textField.placeholderFont = UIFont(name: "Poppins-Medium", size: 17)!
        textField.placeholderColor = .textAndIcons
        return textField
    }()
    
    lazy var imagePickerButton: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.cornerRadius = 24
        view.clipsToBounds = true
        
        // Add your image view
        let imageView = UIImageView(image: UIImage(named: "cameraFill"))
        imageView.contentMode = .scaleAspectFill  // Changed to fill for rounded corners
        imageView.backgroundColor = .clear  // Set if needed
        imageView.layer.cornerRadius = 20  // Slightly smaller than container
        imageView.clipsToBounds = true
        
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
        
        return view
    }()
    
    
    lazy var ingredientsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Carrot-Icon")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        return imageView
    }()
    
    lazy var ingredientsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Ingredients"
        label.font = UIFont(name: "Poppins-SemiBold", size: 17)
        return label
    }()
    
    lazy var ingredientsPlusImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .greenPlusIcon
        imageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    lazy var ingredientsHorizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [ingredientsImage, ingredientsLabel, UIView(), ingredientsPlusImage])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        return stack
    }()
    
    lazy var ingredientsComponentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [ingredientsHorizontalStack])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.backgroundColor = .backgroundPrimaria
        stackView.layer.cornerRadius = 17
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        return stackView
    }()
    
    lazy var lineSeparator: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = ""
        label.font = UIFont(name: "Poppins-Medium", size: 14)
        label.textColor = .grayText
        return label
    }()
    
    lazy var stepsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Pen-Icon")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        imageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        return imageView
    }()
    
    lazy var stepsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Steps"
        label.font = UIFont(name: "Poppins-SemiBold", size: 17)
        return label
    }()
    
    lazy var stepsPlusImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = .greenPlusIcon
        imageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    lazy var stepsHorizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [stepsImage, stepsLabel, UIView(), stepsPlusImage])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.spacing = 12
        stack.alignment = .center
        return stack
    }()
    
    lazy var stepsComponentStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [stepsHorizontalStack])
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
//        imagePickerButton.addTarget(self, action: #selector(toggleDropdown), for: .touchUpInside)
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
        view.addSubview(nameTextField)
        view.addSubview(imagePickerButton)
        view.addSubview(ingredientsComponentStackView)
        view.addSubview(stepsComponentStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            header.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 88),
            nameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            nameTextField.heightAnchor.constraint(equalToConstant: 42),
            imagePickerButton.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 24),
            imagePickerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            imagePickerButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            imagePickerButton.bottomAnchor.constraint(equalTo: ingredientsComponentStackView.topAnchor, constant: -24),
            ingredientsComponentStackView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 255),
            ingredientsComponentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            ingredientsComponentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            ingredientsComponentStackView.heightAnchor.constraint(equalToConstant: 54),
            stepsComponentStackView.topAnchor.constraint(equalTo: ingredientsComponentStackView.bottomAnchor, constant: 24),
            stepsComponentStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stepsComponentStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stepsComponentStackView.heightAnchor.constraint(equalToConstant: 54),
        ])
    }
}

//
//  AddListVC.swift
//  purrchase
//
//  Created by Maria Santellano on 14/05/25.
//
import UIKit

protocol AddListDelegate: AnyObject {
    func didAddList(list: ProductList)
}

class AddListVC: UIViewController {
    let controller: ProductListController
    
    init(controller: ProductListController) {
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
        header.title = "Add List"
        header.secondButtonTitle = "Done"
        
        header.cancelButtonAction = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        header.doneButtonAction = {[weak self] in
            self?.doneButtonTapped()
        }
        
        return header
    }()
    
    lazy var listName: NamedTextField = {
        var listNameTextField = NamedTextField()
        listNameTextField.name = "Name"
        listNameTextField.placeholder = "Name of the List"
        listNameTextField.placeholderColor = .textAndIcons
        return listNameTextField
    }()
    
    lazy var colorSelector: ColorSelector = {
        var colorSelector = ColorSelector()
        return colorSelector
    }()
    
    lazy var stackListDetails: UIStackView = {
        var stackListDetails = UIStackView(arrangedSubviews: [listName, colorSelector])
        stackListDetails.translatesAutoresizingMaskIntoConstraints = false
        stackListDetails.spacing = 24
        stackListDetails.axis = .vertical
        return stackListDetails
    }()
    
    weak var delegate: AddListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapDismissKeyboard = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapDismissKeyboard)
        view.backgroundColor = .white
        
        setup()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func doneButtonTapped() {
        print("Botão done pressionado! ")
        
        guard let name = listName.text, !name.isEmpty else {
            showAlert(title: "Name required!", message: "Please enter a list name.")
            return
        }
        
        guard let selectedColor = colorSelector.selectedColorName else {
            showAlert(title: "Color required", message: "Please select a color.")
            return
        }

        let newList = ProductList(list: [], colorName: selectedColor, name: name)
        controller.addList(newList)
        print("Lista adicionada!")
        controller.repository.printAllProducts()
        
        
        delegate?.didAddList(list: newList)
        dismiss(animated: true)
        
        func showAlert(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }

    }
}

extension AddListVC: ViewCodeProtocol {
    func addSubViews() {
        view.addSubview(header)
        view.addSubview(stackListDetails)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            header.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            stackListDetails.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackListDetails.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            stackListDetails.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 29),
        ])
    }
    
    
}

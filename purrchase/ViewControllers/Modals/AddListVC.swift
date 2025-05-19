//
//  AddListVC.swift
//  purrchase
//
//  Created by Maria Santellano on 14/05/25.
//
import UIKit

class AddListVC: UIViewController {
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
        
//        header.doneButtonAction = { [weak self] in
//            self?.doneButtonTapped()
//        }
        
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
    
    let imagePickerButton = ImagePickerButton()
    // FAZER A FUNCAO DO DoneButtonTapped
//    func doneButtonTapped() {
        // falta coisa aq dentro
//        dismiss(animated: true)
//    }
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

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
        
    let imagePickerButton = ImagePickerButton()
    
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
    
    // FAZER A FUNCAO DO DoneButtonTapped
//    func doneButtonTapped() {
        // falta coisa aq dentro
//        dismiss(animated: true)
//    }
}

extension AddProductVC: ViewCodeProtocol {
    func addSubViews() {
        view.addSubview(header)
        view.addSubview(imagePickerButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            header.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            imagePickerButton.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 15),
            imagePickerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
        ])
    }
}

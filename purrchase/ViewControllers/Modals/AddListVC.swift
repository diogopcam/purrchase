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
    
    // FAZER A FUNCAO DO DoneButtonTapped
//    func doneButtonTapped() {
        // falta coisa aq dentro
//        dismiss(animated: true)
//    }
}

extension AddListVC: ViewCodeProtocol {
    func addSubViews() {
        view.addSubview(header)

    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            header.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            header.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            header.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            ])
    }
    
    
}

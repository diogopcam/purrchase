//
//  PantryVC.swift
//  purrchase
//
//  Created by Diogo Camargo on 13/05/25.
//

import UIKit

class PantryVC: UIViewController {

    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Pantry"
        label.font = UIFont(name: "Quicksand-Bold", size: 40)
        label.textColor = .label
        return label
    } ()
    
    lazy var addProductButton: AddListComponent = {
        var button = AddListComponent()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.name = "Add Product"
        
        // Adiciona o gesto de toque
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addProductTapped))
        button.addGestureRecognizer(tapGesture)
        button.isUserInteractionEnabled = true // Importante para views customizadas
        
        return button
    }()
    
    lazy var catIcon: ImageCatComponent = {
        var catIcon = ImageCatComponent()
        catIcon.translatesAutoresizingMaskIntoConstraints = false
        catIcon.image = .catImage2
        catIcon.name = "Click on “Add Products” to add a new products"
        return catIcon
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "NavBar-Icon1"),
            style: .plain,
            target: self,
            action: #selector(handleComponent)
        )
        navigationController?.navigationBar.tintColor = .textAndIcons
    }
    
    var nameTitle: String? {
        get {
            titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
}

extension PantryVC: ViewCodeProtocol {
    
    func addSubViews() {
        view.addSubview(titleLabel)
        view.addSubview(addProductButton)
        view.addSubview(catIcon)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // MARK: titleLabel
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 98),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // MARK: button
            addProductButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            addProductButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addProductButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            // MARK: catImage
            catIcon.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 211),
            catIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 93),
            catIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -94)
            
        ])
    }
    
    func setupViews() {
        addSubViews()
        setupConstraints()
    }
}

// MARK: Funções do botão
extension PantryVC {
    
    @objc func handleComponent() {
        print("component tapped")
        /// implementar quando der
    }
    
    @objc func addProductTapped() {
        print("Add Product Tapped")
        let addProductVC = AddProductVC()
//        addProductVC.delegate = self //Falta fazer essa parte
        present(addProductVC, animated: true)
    }
    
}

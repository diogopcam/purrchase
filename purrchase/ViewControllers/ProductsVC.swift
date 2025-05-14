//
//  ProductsVC.swift
//  purrchase
//
//  Created by Bernardo Garcia Fensterseifer on 14/05/25.
//

import UIKit

class ProductsVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
    }
    
    /// Aqui será necessário conversar com a modal AddList para pegar esse nome!
    var listName: String = "Rancho da gigi" // botei essa String de exemplo!
    
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = listName
        label.font = UIFont(name: "Quicksand-Bold", size: 40)
        return label
    } ()
    
    lazy var addProductButton: AddListComponent = {
        var button = AddListComponent()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.name = "Add Product"
        return button
    }()
    
    lazy var catIcon: ImageCatComponent = {
        var catIcon = ImageCatComponent()
        catIcon.translatesAutoresizingMaskIntoConstraints = false
        catIcon.image = UIImage(named: "Cat-Image2")
        catIcon.name = "Click on “Add Products” to add a new products"
        return catIcon
    }()
    
}

extension ProductsVC: ViewCodeProtocol {
    
    func addSubViews() {
        view.addSubview(titleLabel)
        view.addSubview(addProductButton)
        view.addSubview(catIcon)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 98),
            titleLabel.heightAnchor.constraint(equalToConstant: 52),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            addProductButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            addProductButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addProductButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addProductButton.heightAnchor.constraint(equalToConstant: 52),
            
            catIcon.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 203),
            catIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 93),
            catIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -94),
        ])
    }
    
    func setupViews() {
        addSubViews()
        setupConstraints()
    }
}

//
//  ProductListVC.swift
//  purrchase
//
//  Created by Bernardo Garcia Fensterseifer on 14/05/25.
//

import UIKit

class ProductListVC: UIViewController {
    let controller: ProductListController
    let productList: ProductList
    
    init(controller: ProductListController, productList: ProductList) {
        self.controller = controller
        self.productList = productList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "NavBar-Icon1"),
            style: .plain,
            target: self,
            action: #selector(handleAddProduct)
        )
        navigationController?.navigationBar.tintColor = .textAndIcons
        setupViews()
    }
    
    @objc func handleAddProduct() {
        print("Add Product Tapped!")
        /// implementar quando tivermos o componente correspondente!!!
    }
    
    lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = productList.name
        label.font = UIFont(name: "Quicksand-Bold", size: 40)
        return label
    } ()

    lazy var addProductButton: AddListComponent = {
        var button = AddListComponent()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.name = "Add Products"
        button.addListButtonAction = { [weak self] in
            self?.addProductTapped()
        }

        return button
    }()
    
    lazy var catIcon: ImageCatComponent = {
        var catIcon = ImageCatComponent()
        catIcon.translatesAutoresizingMaskIntoConstraints = false
        catIcon.image = .catBackground2
        catIcon.name = "Click on “Add Products” to add a new products"
        return catIcon
    }()
    
}

extension ProductListVC: ViewCodeProtocol {
    
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

extension ProductListVC {
    
    @objc func addProductTapped() {
        print("Add Product Tapped")
        let addProductVC = AddProductVC(controller: controller, productList: productList)
//        addProductVC.delegate = self //Falta fazer essa parte
        present(addProductVC, animated: true)
    }
    
}

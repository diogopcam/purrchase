//
//  EditProduct.swift
//  purrchase
//
//  Created by Richard Fagundes Rodrigues on 16/05/25.
//

import UIKit

class EditProductVC: UIViewController {
    
    lazy var headerComponent: NavBarComponent = {
        var navbar = NavBarComponent()
        navbar.translatesAutoresizingMaskIntoConstraints = false
        navbar.firstButtonTitle = "Cancel"
        navbar.title = "Edit Product"
        navbar.secondButtonTitle = "Done"
        
        navbar.cancelButtonAction = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        return navbar
    }()
    
    lazy var productComponent: ProductImageComponent = {
        var productImage = ProductImageComponent()
        productImage.translatesAutoresizingMaskIntoConstraints = false
        productImage.image = .banana
        productImage.name = "Banana"
        return productImage
    }()
    
    lazy var categoryComponent: CategorySelectorComponent = {
        var categorySelector = CategorySelectorComponent()
        categorySelector.translatesAutoresizingMaskIntoConstraints = false
        categorySelector.labelTitle = "Category"
        return categorySelector
    }()
    
    lazy var amount: AmountComponent = {
        var amountComponent = AmountComponent()
        amountComponent.translatesAutoresizingMaskIntoConstraints = false
        return amountComponent
    }()
    
    lazy var delButton: DeleteButtonComponent = {
        var button = DeleteButtonComponent()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setup()
    }
}

extension EditProductVC: ViewCodeProtocol {
    func addSubViews() {
        view.addSubview(headerComponent)
        view.addSubview(productComponent)
        view.addSubview(categoryComponent)
        view.addSubview(amount)
        view.addSubview(delButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerComponent.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerComponent.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerComponent.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            productComponent.topAnchor.constraint(equalTo: headerComponent.bottomAnchor, constant: 41),
            productComponent.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            categoryComponent.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            categoryComponent.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            categoryComponent.topAnchor.constraint(equalTo: productComponent.bottomAnchor, constant: 40),
            categoryComponent.heightAnchor.constraint(equalToConstant: 60),
            
            amount.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            amount.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            amount.topAnchor.constraint(equalTo: categoryComponent.bottomAnchor, constant: 24),
            amount.heightAnchor.constraint(equalToConstant: 50),
            
            delButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            delButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            delButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48),
        ])
    }
}

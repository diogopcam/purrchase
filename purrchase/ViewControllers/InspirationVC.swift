//
//  InspirationVC.swift
//  purrchase
//
//  Created by Diogo Camargo on 13/05/25.
//

import UIKit

class InspirationVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "NavBar-Icon1"),
            style: .plain,
            target: self,
            action: #selector(handleComponent)
        )
        navigationController?.navigationBar.tintColor = .textAndIcons
        
        
        let tapDismissKeyboard = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapDismissKeyboard)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
        
    lazy var inspirationsLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Inspirations"
        label.font = UIFont(name: "Quicksand-Bold", size: 40)
        label.textColor = .label
        return label
    }()
    
    private lazy var searchController: UISearchBar = {
        var search = UISearchBar()
        search.translatesAutoresizingMaskIntoConstraints = false
        search.searchBarStyle = .minimal
        search.placeholder = "Search"

        return search
    }()
    
    lazy var addNewRecipeButton: AddListComponent = {
        var button = AddListComponent()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.name = "Add New Recipe"
        button.addListButtonAction = { [weak self] in
            self?.addProductTapped()
        }
                
        return button
    }()
    
    @objc func addProductTapped() {
        print("Add Product Tapped")
        let addProductVC = AddInspirationVC()
        present(addProductVC, animated: true)
    }
    
    lazy var recipeCard: RecipeCardComponent = {
        var card = RecipeCardComponent()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.name = "Cookies"
        
        return card
    }()
    
    @objc func handleComponent() {
        print("component tapped")
        /// implementar quando der
    }
}

extension InspirationVC: ViewCodeProtocol {
    
    func addSubViews() {
        view.addSubview(inspirationsLabel)
        view.addSubview(searchController)
        view.addSubview(addNewRecipeButton)
        view.addSubview(recipeCard)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            //MARK: Title Inspirations
            inspirationsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            inspirationsLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            inspirationsLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            searchController.topAnchor.constraint(equalTo: inspirationsLabel.bottomAnchor, constant: 12),
            searchController.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 6),
            searchController.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            searchController.heightAnchor.constraint(equalToConstant: 36),
            
            
            
            addNewRecipeButton.topAnchor.constraint(equalTo: searchController.bottomAnchor, constant: 24),
            addNewRecipeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addNewRecipeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            
            recipeCard.topAnchor.constraint(equalTo: addNewRecipeButton.bottomAnchor, constant: 32),
            recipeCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            recipeCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
}

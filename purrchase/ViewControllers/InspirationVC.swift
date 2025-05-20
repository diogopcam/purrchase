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
        setupViews()
    }
    
    lazy var inspirationsLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Inspirations"
        label.font = UIFont(name: "Quicksand-Bold", size: 32)
        return label
    }()
    
    private lazy var searchController: UISearchController = {
        var search = UISearchController.create()
        search.searchResultsUpdater = self
        search.searchBar.delegate = self
        return search
    }()
    
    lazy var addNewRecipeButton: AddListComponent = {
        var button = AddListComponent()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.name = "Add New Recipe"
        return button
    }()
    
}

extension InspirationVC: ViewCodeProtocol {
    
    func addSubViews() {
        view.addSubview(inspirationsLabel)
        navigationItem.searchController = searchController
        view.addSubview(searchController.searchBar)
        view.addSubview(addNewRecipeButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            inspirationsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            inspirationsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            inspirationsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchController.searchBar.topAnchor.constraint(equalTo: inspirationsLabel.bottomAnchor, constant: 16),
            searchController.searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchController.searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addNewRecipeButton.topAnchor.constraint(equalTo: inspirationsLabel.bottomAnchor, constant: 39),
            addNewRecipeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addNewRecipeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    func setupViews() {
        addSubViews()
        setupConstraints()
    }
    
}

// MARK: SearchResults
extension InspirationVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        print("Degbug: \(searchController.searchBar.text ?? "")")
    }
}

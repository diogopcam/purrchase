//
//  ListsVC.swift
//  purrchase
//
//  Created by Diogo Camargo on 13/05/25.
//

import UIKit

class ListsVC: UIViewController {

    lazy var welcomeLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome To Purrchase!"
        label.font = UIFont(name: "Quicksand-Bold", size: 32)
        label.textColor = .tertiary
        return label
    } ()
    
    lazy var yellowView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .backgroundYellow
        view.addSubview(welcomeLabel)
        return view
    }()
    
    lazy var addListButton: AddListComponent = {
        var button = AddListComponent()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addListButtonAction = { [weak self] in
            self?.addListButtonTapped()
        }

        return button
    }()
    
    lazy var catIcon: ImageCatComponent = {
        var catIcon = ImageCatComponent()
        catIcon.translatesAutoresizingMaskIntoConstraints = false
        return catIcon
    }()
    
    //MARK: List
    lazy var listCard: ListCard = {
        var list = ListCard()
        list.descriptionText = "Lista Padrão"
        list.titleText = "Rancho"
        list.translatesAutoresizingMaskIntoConstraints = false
        return list
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    @objc func addListButtonTapped() {
        let addListVC = AddListVC()
//        addListVC.delegate = self //Falta fazer essa parte
        present(addListVC, animated: true)
    }
}

extension ListsVC: ViewCodeProtocol {
    
    func addSubViews() {
        view.addSubview(yellowView)
        view.addSubview(addListButton)
        view.addSubview(listCard)
        view.addSubview(catIcon)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            // MARK: welcomeToPurrchase
            yellowView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            yellowView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            yellowView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            yellowView.heightAnchor.constraint(equalToConstant: 133),
            welcomeLabel.centerXAnchor.constraint(equalTo: yellowView.centerXAnchor),
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 74),
            
            // MARK: addListButton
            addListButton.topAnchor.constraint(equalTo: yellowView.bottomAnchor, constant: 20),
            addListButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addListButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            //MARK: List Card
            listCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            listCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            listCard.topAnchor.constraint(equalTo: addListButton.bottomAnchor, constant: 14),
            
            //MARK: Cat icon
            catIcon.topAnchor.constraint(equalTo: yellowView.bottomAnchor, constant: 236),
            catIcon.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            catIcon.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    func setupViews() {
        addSubViews()
        setupConstraints()
    }
}

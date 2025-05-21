//
//  Untitled.swift
//  purrchase
//
//  Created by Maria Santellano on 19/05/25.
//

import UIKit

extension ListsVC: ViewCodeProtocol {
    
    func addSubViews() {
        view.addSubview(yellowView)
        view.addSubview(addListButton)
        view.addSubview(collectionView)
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
            
            //MARK: Collection View
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: addListButton.bottomAnchor, constant: 8),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            
            catIcon.topAnchor.constraint(equalTo: addListButton.bottomAnchor, constant: 140),
            catIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}
